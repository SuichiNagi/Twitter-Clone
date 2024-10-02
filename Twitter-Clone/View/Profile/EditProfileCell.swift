//
//  EditProfileCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 10/3/24.
//

import UIKit

protocol EditProfileCellDelegate: AnyObject {
    func updateUserInfo(_ cell: EditProfileCell)
}

class EditProfileCell: UITableViewCell {
    
    static let reuseIdentifier = "EditProfileCell"
    
    weak var delegate: EditProfileCellDelegate?
    
    var viewModel: EditProfileViewModel? {
        didSet {
            config()
        }
    }
    
    //MARKL Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setNotifObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func handleUpdateUserInfo() {
        delegate?.updateUserInfo(self)
    }
    
    //MARK: Helpers
    
    func setNotifObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateUserInfo), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
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
        
        [titleLabel, infoTextField, bioTextView].forEach(contentView.addSubview(_:))
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalTo(contentView).offset(12)
            make.left.equalTo(contentView).offset(16)
        }
        
        let viewArr = [infoTextField, bioTextView]
        
        for view in viewArr {
            view.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(4)
                make.left.equalTo(titleLabel.snp.right).offset(16)
                make.bottom.equalTo(contentView)
                make.right.equalTo(contentView).offset(-8)
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 14)
        textField.textAlignment = .left
        textField.textColor = ThemeColor.twitterBlue
        textField.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        return textField
    }()
    
    lazy var bioTextView: InputTextView = {
        let textView = InputTextView()
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = ThemeColor.twitterBlue
        textView.placeholderLabel.text = "Bio"
        return textView
    }()
}
