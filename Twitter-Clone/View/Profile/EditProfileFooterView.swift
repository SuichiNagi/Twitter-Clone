//
//  EditProfileFooter.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 10/4/24.
//

import UIKit

protocol EditProfileFooterViewDelegate: AnyObject {
    func handleLogoutButtonTapped()
}

class EditProfileFooterView: UIView {
    
    weak var delegate: EditProfileFooterViewDelegate?
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height: CGFloat = self.frame.height - 6
        let width: CGFloat = self.frame.width - 60
        
        logoutButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: width, height: height))
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func logoutButtonTapped() {
        delegate?.handleLogoutButtonTapped()
    }
    
    //MARK: Properties
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ThemeColor.twitterBlue
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
}
