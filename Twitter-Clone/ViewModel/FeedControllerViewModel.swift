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
    
//    func fetchTweets(completion: @escaping () -> Void) {
//        TweetService.shared.fetchTweets { [weak self] tweets in
//            guard let self = self else { return }
//            
//            self.tweets = tweets
//            self.checkIfUserLikedTweet(tweets) { [weak self] in
//                self?.didFetchTweets?()
//            }
//        }
//        completion()
//    }
    
    func checkIfUserLikedTweet(_ tweets: [TweetModel], completion: @escaping () -> Void) {
           let group = DispatchGroup()
           
           for (index, tweet) in tweets.enumerated() {
               group.enter() //To add tasks to the group.
               TweetService.shared.checkIfUserLikedTweet(tweet) { [weak self] didLike in
                   guard let self else { return }
                   
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
        TweetService.shared.likeTweet(tweet: tweet) { [weak cell] err, ref in
            guard let cell else { return }
            
            DispatchQueue.main.async {
                cell.tweet?.didLike.toggle()
                let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
                cell.tweet?.likes = likes
                
                DispatchQueue.global(qos: .background) .async {
                    guard !tweet.didLike else { return }
//                    NotificationService.shared.uploadNotification(type: .like, tweet: tweet)
                }
                completion()
            }
        }
    }
    
    func didLikeTweet(tweet: TweetModel, cell: TweetCell) {
        TweetService.shared.checkIfUserLikedTweet(tweet) { [weak cell] didLike in
            guard let cell else { return }
            cell.tweet?.didLike = didLike
        }
    }
    
    func checkIfUserLikeAndHowManyLikes(tweet: TweetModel, controller: TweetController, completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        // Enter the dispatch group before starting the async call
        dispatchGroup.enter()
        TweetService.shared.checkHowManyLikesTweetHas(tweet) { [weak controller] likes in
            guard let controller else { return }
            controller.viewModel.tweet.likes = likes
            dispatchGroup.leave()  // Leave when the async call finishes
        }
        
        // Enter the dispatch group before starting the async call
        dispatchGroup.enter()
        TweetService.shared.checkIfUserLikedTweet(tweet) { [weak controller] didLike in
            guard let controller else { return }
            controller.viewModel.tweet.didLike = didLike
            dispatchGroup.leave()  // Leave when the async call finishes
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
   
}
