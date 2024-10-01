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
            guard let self = self else { return }
            
            self.tweets = tweets.sorted(by: { $0.timestamp > $1.timestamp })
            self.checkIfUserLikedTweet() { [weak self] in
                self?.didFetchTweets?()
            }
        }
    }
    
    func checkIfUserLikedTweet(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()

        self.tweets.forEach { tweet in
            dispatchGroup.enter()
            TweetService.shared.checkIfUserLikedTweet(tweet) { [weak self] didLike in
                if let index = self?.tweets.firstIndex(where: { $0.tweetID == tweet.tweetID }), didLike == true {
                    self?.tweets[index].didLike = true
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
       
    func likeTweet(tweet: TweetModel, cell: TweetCell, completion: @escaping () -> Void) {
        TweetService.shared.likeTweet(tweet: tweet) { [weak cell] err, ref in
            guard let cell else { return }
            
            DispatchQueue.main.async {
                cell.tweet?.didLike.toggle()
                let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
                cell.tweet?.likes = likes
                
                DispatchQueue.global(qos: .background) .async {
                    guard !tweet.didLike else { return }
                    NotificationService.shared.uploadNotification(type: .like, tweet: tweet)
                }
                completion()
            }
        }
    }
}
