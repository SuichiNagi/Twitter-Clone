//
//  TweetHeaderView.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/6/24.
//

import UIKit

class TweetHeaderView: UICollectionReusableView {
    
    static let headerIdentifier = "TweetHeaderView"
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
}
