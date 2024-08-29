//
//  FeedController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    
    var user: UserModel? {
        didSet { configLeftBarButton() }
    }
    
    private var tweets = [TweetModel]() {
        didSet { collectionView.reloadData() }
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchTweets()
    }
    
    //MARK: API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { [weak self] tweets in
            guard let self else { return }
            
            self.tweets = tweets
        }
    }
    
    //MARK: Helpers
    
    func configLeftBarButton() {
        guard let user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseIdentifier)
        
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        navigationItem.titleView = iconImage
    }
    
    //MARK: Properties
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 32 / 2
        image.layer.masksToBounds = true
        return image
    }()
}

//MARK: UICollectionViewDelegate/DataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseIdentifier, for: indexPath) as! TweetCell
        cell.delegate = self
        
        let tweet = tweets[indexPath.row]
        cell.set(tweet: tweet)
        
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

//MARK: TweetCellDelegate

extension FeedController: TweetCellDelegate {
    func handleProfileImageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}
