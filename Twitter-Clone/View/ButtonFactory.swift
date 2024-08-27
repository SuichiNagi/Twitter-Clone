//
//  ButtonFactory.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/27/24.
//

import UIKit

struct ButtonFactory {
    
    static func build(image: UIImage?,
                      tintColor: UIColor = .darkGray) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        return button
    }
}
