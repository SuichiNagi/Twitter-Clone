//
//  TweetController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/6/24.
//

import UIKit

class TweetController: UICollectionViewController {
    
    //MARK: Properties
    
    private let viewModel: TweetViewModel
    private var replies = [TweetModel]() {
        didSet { collectionView.reloadData() }
    }
    
    private var actionSheetLauncher: ActionSheetLauncher!
    
    //MARK: Lifecycle
    
    init(tweet: TweetModel) {
        viewModel = TweetViewModel(tweet: tweet)
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchReplies()
    }
    
    //MARK: API
    
    func fetchReplies() {
        TweetService.shared.fetchReplies(forTweet: self.viewModel.tweet) { [weak self] replies in
            guard let self else { return }
            self.replies = replies
        }
    }
    
    //MARK: Helpers
    
    fileprivate func showingActionSheet(forUser user: UserModel) {
        actionSheetLauncher = ActionSheetLauncher(user: user)
        actionSheetLauncher.delegate = self
        actionSheetLauncher.show()
    }
    
    private func setUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseIdentifier)
        collectionView.register(TweetHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TweetHeaderView.headerIdentifier)
    }
}

//MARK: UICollectionViewDataSource/UICollectionViewDelegate

extension TweetController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TweetHeaderView.headerIdentifier, for: indexPath) as! TweetHeaderView
        
        header.delegate = self
        header.set(tweet: viewModel.tweet)
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseIdentifier, for: indexPath) as! TweetCell
        
        let replies = replies[indexPath.row]
        cell.set(tweet: replies)
        
        return cell
    }
}

//MARK: UICollectionViewFlowLayout

extension TweetController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.getCaptionHeight(view: view)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

//MARK: TweetHeaderViewDelegate

extension TweetController: TweetHeaderViewDelegate {
    
    func showActionSheet() {
        if viewModel.user.isCurrentUser {
            showingActionSheet(forUser: viewModel.user)
        } else {
            UserService.shared.checkIfUserIsFollowed(uid: viewModel.user.uid) { [weak self] isFollowed in
                guard let self else { return }
                var user = self.viewModel.tweet.user
                user.isFollowed = isFollowed
                self.showingActionSheet(forUser: user)
            }
        }
    }
}

//MARK: ActionSheetLauncherDelegate

extension TweetController: ActionSheetLauncherDelegate {
    func didSelect(option: ActionSheetOptions) {
        viewModel.actionSheetOptions(option)
    }
}

