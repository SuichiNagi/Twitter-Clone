//
//  UploadTweetController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/26/24.
//

import UIKit
import ActiveLabel

class UploadTweetController: UIViewController {
    
    private let userModel: UserModel
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        configMentionHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    init(user: UserModel, config: UploadTweetConfiguration) {
        self.userModel = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        
        TweetService.shared.uploadTweet(caption: caption, type: config) { [weak self] error, ref in
            guard let self else { return }
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            if case .reply(let tweet) = self.config {
                NotificationService.shared.uploadNotification(toUser: tweet.user,
                                                              type: .reply,
                                                              tweetID: tweet.tweetID)
                
                uploadMentionNotification(forCaption: caption, tweetID: tweet.tweetID)
            }
            
            self.dismiss(animated: true)
        }
    }
    
    //MARK: API
    
    fileprivate func uploadMentionNotification(forCaption caption: String, tweetID: String?) {
        guard caption.contains("@") else { return }
        let words = caption.components(separatedBy: .whitespacesAndNewlines)
        
        words.forEach { word in
            guard word.hasPrefix("@") else { return }
            
            var username = word.trimmingCharacters(in: .symbols)
            username = username.trimmingCharacters(in: .punctuationCharacters)
            
            UserService.shared.fetchUser(withUsername: username) { mentionedUser in
                NotificationService.shared.uploadNotification(toUser: mentionedUser,
                                                              type: .mention,
                                                              tweetID: tweetID)
            }
        }
    }
    
    //MARK: Helpers
    
    private func configMentionHandler() {
        replyLabel.handleMentionTap { mention in
            UserService.shared.fetchUser(withUsername: mention) { [weak self] user in
                guard let self else { return }
                let controller = ProfileController(user: user)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    private func configNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    private func setUI() {
        configNavBar()
        view.backgroundColor = .white

        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        setTextAndTitle()
    }
    
    private func setTextAndTitle() {
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard viewModel.replyText != nil else { return }
        replyLabel.text = viewModel.replyText
    }
    
    //MARK: Properties
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.backgroundColor = ThemeColor.twitterBlue
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView: TCImageView = {
        let image = TCImageView(image: userModel.profileImageUrl!)
        image.layer.cornerRadius = 48 / 2
        return image
    }()
    
    private lazy var captionTextView: InputTextView = {
        let textView = InputTextView()
        return textView
    }()
    
    private lazy var imageCaptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var replyLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.mentionColor = ThemeColor.twitterBlue
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
}
