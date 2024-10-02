//
//  EditProfileCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 10/3/24.
//

import UIKit

class EditProfileCell: UITableViewCell {
    
    static let reuseIdentifier = "EditProfileCell"
    
    var viewModel: EditProfileViewModel? {
        didSet {
            config()
        }
    }
    
    //MARKL Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func handleUpdateUserInfo() {
        
    }
    
    //MARK: Helpers
    
    private func config() {
        guard let viewModel else { return }
        
        infoTextField.isHidden = viewModel.shouldHideTextField
        bioTextView.isHidden = viewModel.shouldHideTextView
        
        titleLabel.text = viewModel.titleText
        infoTextField.text = viewModel.optionValue
        bioTextView.text = viewModel.optionValue
    }
    
    private func setUI() {
        selectionStyle = .none
        
        [titleLabel, infoTextField, bioTextView].forEach(addSubview(_:))
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        let viewArr = [infoTextField, bioTextView]
        
        for view in viewArr {
            view.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(4)
                make.left.equalTo(titleLabel.snp.right).offset(16)
                make.bottom.equalToSuperview()
                make.right.equalToSuperview().offset(-8)
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 14)
        textField.textAlignment = .left
        textField.textColor = ThemeColor.twitterBlue
        textField.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        return textField
    }()
    
    private lazy var bioTextView: InputTextView = {
        let textView = InputTextView()
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = ThemeColor.twitterBlue
        textView.placeholderLabel.text = "Bio"
        return textView
    }()
}
