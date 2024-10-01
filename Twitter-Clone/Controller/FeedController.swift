//
//  FeedController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    
    var feedControllerVM = FeedControllerViewModel()

    var user: UserModel? {
        didSet { configLeftBarButton() }
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setupBindings()
        feedControllerVM.fetchTweets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: Selectors
    
    @objc func handleRefresh() {
        feedControllerVM.fetchTweets()
    }
    
    //MARK: Helpers
    
    private func setupBindings() {
        collectionView.refreshControl?.beginRefreshing()
        // Bind the ViewModel closure to reload data
        feedControllerVM.didFetchTweets = { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func configLeftBarButton() {
        guard let user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.8)
        }
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseIdentifier)
        
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        navigationItem.titleView = iconImage
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    //MARK: Properties
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView(image: IconImage.tweetLogoBlue)
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
        return feedControllerVM.tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseIdentifier, for: indexPath) as! TweetCell
        cell.delegate = self
        
        let tweet = feedControllerVM.tweets[indexPath.row]
        
        cell.tweet = tweet
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tweet = feedControllerVM.tweets[indexPath.row]
        let controller = TweetController(tweet: tweet)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tweet = feedControllerVM.tweets[indexPath.row]
        let viewModel = TweetViewModel(tweet: tweet)
        let captionHeight = viewModel.size(forWidth: view.frame.width).height
        
        return CGSize(width: view.frame.width, height: captionHeight + 72)
    }
}

//MARK: TweetCellDelegate

extension FeedController: TweetCellDelegate {
    func handleReplyTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        let controller = UploadTweetController(user: tweet.user, config: .reply(tweet))
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func handleProfileImageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func handleLikeTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        
        feedControllerVM.likeTweet(tweet: tweet, cell: cell) { [weak self] in
            guard let self else { return }
            self.feedControllerVM.fetchTweets()
        }
    }
}
