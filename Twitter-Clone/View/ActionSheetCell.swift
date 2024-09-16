//
//  ActionSheetCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/16/24.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    static let reuseIdentifier = "ActionSheetCell"
    
    //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    
    private func setUI() {
        addSubview(optionImageView)
        optionImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(optionImageView.snp.right).offset(12)
        }
    }
    
    private lazy var optionImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = IconImage.tweetLogoBlue
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Test Option"
        return label
    }()
    
    
}
