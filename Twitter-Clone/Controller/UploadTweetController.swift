//
//  UploadTweetController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/26/24.
//

import UIKit

class UploadTweetController: UIViewController {
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    //MARK: Selectors
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handleUploadTweet() {
        
    }
    
    //MARK: Helpers
    
    private func setUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
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
}
