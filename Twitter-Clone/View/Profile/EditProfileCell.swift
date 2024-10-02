//
//  EditProfileCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 10/3/24.
//

import UIKit

class EditProfileCell: UITableViewCell {
    
    static let reuseIdentifier = "EditProfileCell"
    
    //MARKL Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
