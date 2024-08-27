//
//  TweetCell.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/27/24.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    var itemViews: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc private func handleCommentTapped() {

    }
    
    @objc private func handleRetweetTapped() {
        
    }
    
    @objc private func handleLikeTapped() {
        
    }
    
    @objc private func handleShareTapped() {
        
    }
    
    //MARK: Helpers
    
    func setUI() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(profileImageView.snp.right).offset(12)
        }
        
        addSubview(underLineView)
        underLineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        itemViews = [commentButton, retweetButton, likeButton, shareButton]
        
        for itemView in itemViews {
            itemView.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
        }
        
        addSubview(actionStackView)
        actionStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }
    }
    
    
    //MARK: Properties
    
    private lazy var profileImageView: TCImageView = {
        let image = TCImageView(frame: .zero)
        image.backgroundColor = UIColor.green
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Jokeeeeeeer"
        return label
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "huwaw"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var actionStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: itemViews)
        stack.axis = .horizontal
        stack.spacing = 72
        return stack
    }()
    
    private lazy var commentButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.commentIcon)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.retweetIcon)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.likeIcon)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = ButtonFactory.build(image: IconImage.shareIcon)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var underLineView: UIView = {
        let underLine = UIView()
        underLine.backgroundColor = .systemGroupedBackground
        return underLine
    }()
}