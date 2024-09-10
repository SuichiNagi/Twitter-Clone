//
//  FeedControllerViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/6/24.
//

import Foundation

class FeedControllerViewModel {
    
    var tweets = [TweetModel]()
    
    var didFetchTweets: (() -> Void)?
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { [weak self] tweets in
            guard let self else { return }
            
            self.tweets = tweets
            self.didFetchTweets?()
        }
    }
}
