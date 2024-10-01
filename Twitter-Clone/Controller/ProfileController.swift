//
//  ProfileController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/28/24.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    let layout = UICollectionViewFlowLayout()
    
    let profileControllerVM: ProfileControllerViewModel
    
    init(user: UserModel) {
        self.profileControllerVM = ProfileControllerViewModel(user: user)
        super.init(collectionViewLayout: layout)
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: API
    
    private func fetchData() {
        profileControllerVM.fetchData()
        setupBindings()
    }
    
    //MARK: Helpers
    
    private func setupBindings() {
        // Bind the ViewModel closure to reload data
        profileControllerVM.didFetch = { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
        }
    }
    
    private func setUI() {
        layout.sectionHeadersPinToVisibleBounds = true // Makes the header sticky
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseIdentifier)
        collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderView.headerIndentifier)
        
        guard let tabBarHeight = self.tabBarController?.tabBar.frame.size.height else { return }
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size.height - tabBarHeight)
        collectionView.contentInset.bottom = tabBarHeight
    }
}

//MARK: UICollectionViewDataSource/UICollectionViewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderView.headerIndentifier, for: indexPath) as! ProfileHeaderView
        
        header.user = profileControllerVM.user
        header.delegate = self
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileControllerVM.currentDataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseIdentifier, for: indexPath) as! TweetCell
        
        let tweet = profileControllerVM.currentDataSource[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TweetController(tweet: profileControllerVM.currentDataSource[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: UICollectionViewFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tweet = profileControllerVM.currentDataSource[indexPath.row]
        let viewModel = TweetViewModel(tweet: tweet)
        var captionHeight = viewModel.size(forWidth: view.frame.width).height + 72
        
        if tweet.isReply {
            captionHeight += 22
        }
        
        return CGSize(width: view.frame.width, height: captionHeight)
    }
}

//MARK: ProfileHeaderViewDelegate

extension ProfileController: ProfileHeaderViewDelegate {
    func didSelect(filter: ProfileFilterOptions) {
        profileControllerVM.selectedFilter = filter
    }
    
    func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleEditProfileFollow(_ header: ProfileHeaderView) {
        profileControllerVM.handleEditProfileFollow()
    }
    
}
