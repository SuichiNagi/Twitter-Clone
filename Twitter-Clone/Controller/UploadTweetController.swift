//
//  UploadTweetController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/26/24.
//

import UIKit

class UploadTweetController: UIViewController {
    
    private let userModel: UserModel
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        switch config {
        case .tweet:
            print("Config is tweet")
        case .reply(let tweetModel):
            print("Replying to \(tweetModel.user.username)")
        }
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
        
        TweetService.shared.uploadTweet(caption: caption) { [weak self] error, ref in
            guard let self else { return }
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            self.dismiss(animated: true)
        }
    }
    
    //MARK: Helpers
    
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
    }
    
    //MARK: Properties
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.backgroundColor = ThemeColor.twitterBlue
        button.setTitle("Tweet", for: .normal)
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
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var captionTextView: CaptionTextView = {
        let textView = CaptionTextView()
        return textView
    }()
}
