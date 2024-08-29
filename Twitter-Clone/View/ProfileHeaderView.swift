//
//  ProfileHeaderView.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/28/24.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func handleDismiss()
}

class ProfileHeaderView: UICollectionReusableView {
    
    static let headerIndentifier = "ProfileHeaderView"
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    var user: UserModel? {
        didSet { config() }
    }
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func handleDismissal() {
        delegate?.handleDismiss()
    }
    
    @objc private func handleEditProfileFollow() {
        
    }
    
    @objc private func handleFollowingTapped() {
        
    }
    
    @objc private func handleFollowersTapped() {
        
    }
    
    //MARK: Helpers
    
    func config() {
        guard let user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        fullnameLabel.text = viewModel.fullnameString
        usernameLabel.text = viewModel.usernameString
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
    }
    
    private func setUI() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(108)
        }
        
        containerView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(30)
        }
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(-24)
            make.left.equalToSuperview().offset(8)
            make.width.height.equalTo(80)
        }
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(100)
            make.height.equalTo(32)
        }
        
        addSubview(userDetailStack)
        userDetailStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        addSubview(followStackView)
        followStackView.snp.makeConstraints { make in
            make.top.equalTo(userDetailStack.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
        }
        
        addSubview(filterBar)
        filterBar.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(frame.size.width / 3)
            make.height.equalTo(2)
        }
    }
    
    //MARK: Properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.twitterBlue
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(IconImage.backImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView: TCImageView = {
        let image = TCImageView(frame: .zero)
        image.backgroundColor = .lightGray
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 4
        image.layer.cornerRadius = 80 / 2
        return image
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = ThemeColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.layer.cornerRadius = 32 / 2
        button.setTitleColor(ThemeColor.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return button
    }()
    
    private lazy var userDetailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        return stack
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    private lazy var followStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var filterBar: ProfileFilterView = {
        let filterBar = ProfileFilterView()
        filterBar.delegate = self
        return filterBar
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.twitterBlue
        return view
    }()
}

//MARK: ProfileFilterViewDelegate

extension ProfileHeaderView: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else { return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}
