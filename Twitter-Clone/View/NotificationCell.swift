//
//  NotificationCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/22/24.
//


import UIKit

protocol NotificationCellDelegate: AnyObject {
    func didTapProfileImage(_ cell: NotificationCell)
    func didTapFollow(_ cell: NotificationCell)
}

class NotificationCell: UITableViewCell {
    
    static let reuseIdentifier = "NotificationCell"
    
    var notification: NotificationModel? {
        didSet { config() }
    }
    
    weak var delegate: NotificationCellDelegate?
    
    //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selector
    
    @objc private func handleProfileImageTapped() {
        delegate?.didTapProfileImage(self)
    }
    
    @objc private func handleFollowTapped() {
        delegate?.didTapFollow(self)
    }
    
    //MARK: Helper
    
    func config() {
        guard let notification else { return }
        let viewModel = NotificationViewModel(notification: notification)
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        notificationLabel.attributedText = viewModel.notificationText
        
        followButton.isHidden = viewModel.shouldHideFollowButton
        followButton.setTitle(viewModel.followButtonText, for: .normal)
    }
    
    private func setUI() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(12)
            make.right.equalTo(contentView).offset(-12)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        contentView.addSubview(followButton)
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 92, height: 32))
            make.right.equalTo(contentView).offset(-12)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, notificationLabel])
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var profileImageView: TCImageView = {
        let image = TCImageView(frame: .zero)
        image.layer.cornerRadius = 40 / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        image.addGestureRecognizer(tap)
        return image
    }()
    
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.setTitleColor(ThemeColor.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32 / 2
        button.layer.borderColor = ThemeColor.twitterBlue.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return button
    }()
}
