//
//  LoginController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/22/24.
//

import UIKit

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = ThemeColor.twitterBlue
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.width.equalTo(150)
        }
    }
    
    private lazy var logoImageView: UIImageView = {
        let logoImage = UIImageView()
        logoImage.contentMode = .scaleAspectFit
        logoImage.clipsToBounds = true
        logoImage.image = IconImage.tweetLogo
        return logoImage
    }()
}
