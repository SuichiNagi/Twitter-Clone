//
//  NotificationCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/22/24.
//


import UIKit

class NotificationCell: UITableViewCell {
    
    static let reuseIdentifier = "NotificationCell"
    
    var notification: NotificationModel? {
        didSet { config() }
    }
    
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
        
    }
    
    //MARK: Helper
    
    func config() {
        guard let notification else { return }
        let viewModel = NotificationViewModel(notification: notification)
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        notificationLabel.attributedText = viewModel.notificationText
    }
    
    private func setUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
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
}
