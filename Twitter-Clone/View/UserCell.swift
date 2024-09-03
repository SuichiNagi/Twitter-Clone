//
//  UserCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/3/24.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let reuseIdentifier = "UserCell"
    
    //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    
    func set(user: UserModel) {
        profileImageView.sd_setImage(with: user.profileImageUrl)
        usernameLabel.text = user.username
        fullnameLabel.text = user.fullname
    }
    
    func setUI() {
        [profileImageView, stackView].forEach(addSubview(_:))
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(12)
        }
    }
    
    //MARK: Properties
    
    private lazy var profileImageView: TCImageView = {
        let image = TCImageView(frame: .zero)
        image.layer.cornerRadius = 40 / 2
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
}
