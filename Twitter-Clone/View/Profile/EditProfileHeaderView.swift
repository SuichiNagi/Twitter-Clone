//
//  EditProfileHeaderView.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 10/3/24.
//

import UIKit

protocol EditProfileHeaderViewDelegate: AnyObject {
    func didTapChangeProfilePhoto()
}

class EditProfileHeaderView: UIView {
    
    weak var delegate: EditProfileHeaderViewDelegate?
    
    private let user: UserModel
    
    //MARK: Lifecycle
    
    init(user: UserModel) {
        self.user = user
        super.init(frame: .zero)

        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func handleChangeProfilePhoto() {
        delegate?.didTapChangeProfilePhoto()
    }
    
    private func setUI() {
        backgroundColor = ThemeColor.twitterBlue
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-16)
            make.height.width.equalTo(100)
        }
        
        addSubview(changePhotoButton)
        changePhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_setImage(with: user.profileImageUrl)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3.0
        imageView.layer.cornerRadius = 100 / 2
        return imageView
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Profile Photo", for: .normal)
        button.addTarget(self, action: #selector(handleChangeProfilePhoto), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 14.0)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        return button
    }()
}
