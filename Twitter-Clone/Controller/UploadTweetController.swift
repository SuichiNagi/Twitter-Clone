//
//  UploadTweetController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/26/24.
//

import UIKit

class UploadTweetController: UIViewController {
    
    private let userModel: UserModel
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    init(user: UserModel) {
        self.userModel = user
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
        
    }
    
    //MARK: Helpers
    
    private func configNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        configNavBar()
        
        profileImageView.sd_setImage(with: self.userModel.profileImageUrl)
        
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalToSuperview().offset(16)
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
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = ThemeColor.twitterBlue
        image.clipsToBounds = true
        image.layer.cornerRadius = 48 / 2
        return image
    }()
}
