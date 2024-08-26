//
//  FeedController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    var user: UserModel? {
        didSet {
            configLeftBarButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func configLeftBarButton() {
        guard let user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        navigationItem.titleView = iconImage
    }
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 32 / 2
        image.layer.masksToBounds = true
        return image
    }()
}
