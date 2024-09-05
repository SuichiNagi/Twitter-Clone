//
//  ProfileController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/28/24.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    private var tweets = [TweetModel]() {
        didSet { collectionView.reloadData() }
    }
    
    private var user: UserModel
    
    init(user: UserModel) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchTweets()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { [weak self] tweets in
            guard let self else { return }
            self.tweets = tweets
        }
    }
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { [weak self] isFollowed in
            guard let self else { return }
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.shared.fetchUserStats(uid: user.uid) { [weak self] stats in
            guard let self else { return }
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Helpers
    
    private func setUI() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseIdentifier)
        collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderView.headerIndentifier)
    }
}

//MARK: UICollectionViewDataSource/UICollectionViewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderView.headerIndentifier, for: indexPath) as! ProfileHeaderView
        
        header.user = user
        header.delegate = self
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseIdentifier, for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        cell.set(tweet: tweet)
        
        return cell
    }
}

//MARK: UICollectionViewFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

//MARK: ProfileHeaderViewDelegate

extension ProfileController: ProfileHeaderViewDelegate {
    func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleEditProfileFollow(_ header: ProfileHeaderView) {
    
        if user.isCurrentUser {
            return
        }
        
        if user.isFollowed {
            UserService.shared.unfollowUser(uid: user.uid) { [weak self] err, ref in
                guard let self else { return }
                self.user.isFollowed = false
                collectionView.reloadData()
            }
        } else {
            UserService.shared.followUser(uid: user.uid) { [weak self] err, ref in
                guard let self else { return }
                self.user.isFollowed = true
                collectionView.reloadData()
            }
        }        
    }
}
