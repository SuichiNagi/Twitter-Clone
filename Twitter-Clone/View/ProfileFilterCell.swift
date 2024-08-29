//
//  ProfileFilterCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/29/24.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProfileFilterCell"
    
    private let boldFont = UIFont.boldSystemFont(ofSize: 16)
    private let normalFont = UIFont.systemFont(ofSize: 14)
    
    private let selectedColor = ThemeColor.twitterBlue
    private let normalColor = UIColor.lightGray
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? boldFont : normalFont
            titleLabel.textColor = isSelected ? selectedColor : normalColor
        }
    }
    
    //MARK: Helpers
    
    func set(options: ProfileFilterOptions!) {
        titleLabel.text = options.description
    }
    
    func setUI() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    //MARK: Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Filter"
        label.textColor = .lightGray
        label.font = normalFont
        return label
    }()
}
