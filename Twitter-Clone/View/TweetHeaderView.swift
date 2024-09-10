//
//  TweetHeaderView.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/6/24.
//

import UIKit

class TweetHeaderView: UICollectionReusableView {
    
    static let headerIdentifier = "TweetHeaderView"
    
    private var actionButtonArray: [UIButton] = []
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func handleProfileImageTapped() {
        
    }
    
    @objc private func showActionSheet() {
        
    }
    
    @objc private func handleRetweetsTapped() {
        
    }
    
    @objc private func handleLikesTapped() {
        
    }
    
    @objc private func handleCommentTapped() {
        
    }
    
    @objc private func handleShareTapped() {
        
    }
    
    //MARK: Helpers
    
    func set(tweet: TweetModel?) {
        guard let tweet else { return }

        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
        fullnameLabel.text = tweet.user.fullname
        usernameLabel.text = viewModel.usernameText
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        dateLabel.text = viewModel.headerTimeStamp
        retweetsLabel.attributedText = viewModel.retweetAttributedString
        likesLabel.attributedText = viewModel.likesAttributedString
    }
    
    private func setUI() {
        actionButtonArray = [commentButton, retweetButton, likeButton, shareButton]
        
        for actionButton in actionButtonArray {
            actionButton.snp.makeConstraints { make in
                make.height.width.equalTo(20)
            }
        }
        
        [stackView,
         captionLabel,
         dateLabel,
         optionsButton,
         dividerView1,
         statsStackView,
         dividerView2,
         actionStackView
        ].forEach(addSubview(_:))
        
        stackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
        }
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
        }
        
        optionsButton.snp.makeConstraints { make in
            make.centerY.equalTo(stackView)
            make.right.equalToSuperview().offset(-8)
            make.height.width.equalTo(44)
        }
        
        dividerView1.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.left.right.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
        }
        
        statsStackView.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        dividerView2.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.left.right.equalToSuperview()
            make.top.equalTo(statsStackView.snp.bottom)
        }
        
        actionStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    //MARK: Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, labelStackView])
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var profileImageView: TCImageView = {
        let image = TCImageView(frame: .zero)
        image.backgroundColor = ThemeColor.twitterBlue
        image.layer.cornerRadius = 48 / 2
        image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        image.addGestureRecognizer(tap)
        return image
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        stackView.axis = .vertical
        stackView.spacing = -6
        return stackView
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(IconImage.downArrow, for: .normal)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var dividerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var retweetsLabel = UILabel()
    private lazy var likesLabel = UILabel()
    
    private lazy var dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.commentIcon)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.retweetIcon)
        button.addTarget(self, action: #selector(handleRetweetsTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.likeIcon)
        button.addTarget(self, action: #selector(handleLikesTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.shareIcon)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: actionButtonArray)
        stack.spacing = 72
        return stack
    }()
}
