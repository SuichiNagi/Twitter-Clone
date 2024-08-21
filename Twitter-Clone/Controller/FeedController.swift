//
//  FeedController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit

class FeedController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
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
}
