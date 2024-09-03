//
//  TCImageView.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/27/24.
//

import UIKit
import SDWebImage

class TCImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: URL) {
        self.init(frame: .zero)
        sd_setImage(with: image)
    }
    
    func configUI() {
        contentMode = .scaleAspectFill
        backgroundColor = ThemeColor.twitterBlue
        clipsToBounds = true
    }
}
