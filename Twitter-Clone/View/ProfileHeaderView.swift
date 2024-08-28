//
//  ProfileHeaderView.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/28/24.
//

import UIKit

class ProfileHeaderView: UICollectionReusableView {
    
    static let headerIndentifier = "ProfileHeaderView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
