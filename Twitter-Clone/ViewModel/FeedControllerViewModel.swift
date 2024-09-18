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
            
            self.checkIfUserLikedTweet(tweets)

            self.didFetchTweets?()
        }
    }
    
    func checkIfUserLikedTweet(_ tweets: [TweetModel]) {
        for (index, tweet) in tweets.enumerated() {
            TweetService.shared.checkIfUserLikedTweet(tweet) { [weak self] didLike in
                guard let self else { return }
                guard didLike == true else { return }
                
                self.tweets[index].didLike = true
                self.didFetchTweets?()
            }
        }
    }
    
    func likeTweet(tweet: TweetModel, cell: TweetCell) {
        TweetService.shared.likeTweet(tweet: tweet) { err, ref in
            cell.tweet?.didLike.toggle()
            let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
            cell.tweet?.likes = likes
        }
    }
   
}
