//
//  ConversationsController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit

class ConversationsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Messages"
    }
}
