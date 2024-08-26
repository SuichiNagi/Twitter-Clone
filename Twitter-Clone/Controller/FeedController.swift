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
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    //MARK: Helpers
    
    func configLeftBarButton() {
        guard let user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    func setUI() {
        view.backgroundColor = .white

        navigationItem.titleView = iconImage
        
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
    }
    
    //MARK: Properties
    
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
