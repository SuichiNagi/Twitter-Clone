//
//  TweetHeaderView.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/6/24.
//

import UIKit

class TweetHeaderView: UICollectionReusableView {
    
    static let headerIdentifier = "TweetHeaderView"
    
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
    
    //MARK: Helpers
    
    private func setUI() {
        [stackView, 
         captionLabel,
         dateLabel,
         optionsButton,
         dividerView1,
         statsStackView,
         dividerView2
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
        label.text = "Peter Parker"
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "spiderman"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "This is a test caption, Okay this good."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "5:26 PM - 9/05/2020"
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
    
    private lazy var retweetsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "2 Retweets"
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0 Likes"
        return label
    }()
    
    private lazy var dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
}
