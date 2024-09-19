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
               
               self.tweets = tweets
               self.checkIfUserLikedTweet(tweets) { [weak self] in
                   self?.didFetchTweets?()
               }
           }
       }
    
    func checkIfUserLikedTweet(_ tweets: [TweetModel], completion: @escaping () -> Void) {
           let group = DispatchGroup()
           
           for (index, tweet) in tweets.enumerated() {
               group.enter() //To add tasks to the group.
               TweetService.shared.checkIfUserLikedTweet(tweet) { [weak self] didLike in
                   guard let self = self else { return }
                   
                   if didLike {
                       self.tweets[index].didLike = true
                   }
                   group.leave() //To signal the completion of each task.
               }
           }
           
           group.notify(queue: .main) { //To notify after completing all tasks, does not block the current thread; it allows the thread to continue its execution immediately without waiting for the tasks to complete.
               completion()
           }
       }
       
    func likeTweet(tweet: TweetModel, cell: TweetCell, completion: @escaping () -> Void) {
        TweetService.shared.likeTweet(tweet: tweet) { err, ref in
            DispatchQueue.main.async {
                cell.tweet?.didLike.toggle()
                let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
                cell.tweet?.likes = likes
                completion()
            }
        }
    }
   
}
