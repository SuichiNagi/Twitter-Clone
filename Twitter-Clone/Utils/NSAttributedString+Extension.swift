//
//  String+Extension.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/10/24.
//

import UIKit

extension NSAttributedString {
    
    static func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(
            string: "\(value)",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(
            string: "\(text)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.lightGray
            ]))
        
        return attributedTitle
    }
}
