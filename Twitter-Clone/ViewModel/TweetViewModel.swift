//
//  TweetViewModel.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/28/24.
//

import UIKit

struct TweetViewModel {
    
    let tweet: TweetModel
    let user: UserModel
    
    init(tweet: TweetModel) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var retweetAttributedString: NSAttributedString? {
        return NSAttributedString.statsAttributedText(withValue: tweet.retweetCount, text: " Retweets")
    }
    
    var likesAttributedString: NSAttributedString? {
        return NSAttributedString.statsAttributedText(withValue: tweet.likes, text: " Likes")
    }
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " @\(user.username)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " @ ∙ \(timeStamp)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    var likeButtonTintColor: UIColor {
        return tweet.didLike ? .red : .lightGray
    }
    
    var likeButtonImage: UIImage {
        let imageName = tweet.didLike ? IconImage.likeFilled : IconImage.like
        return imageName!
    }
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ∙ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = tweet.caption
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.snp.makeConstraints { make in
            make.width.equalTo(width)
        }
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    //TweetHeaderSection Height
    func getCaptionHeight(view: UIView) -> CGSize {
        let headerHeight: CGSize
        let viewWidth: CGFloat = view.frame.width
        
        let captionHeight = size(forWidth: view.frame.width).height
        
        let captionInt: Int = Int(captionHeight)
        
        switch captionInt {
        case ...20:
            headerHeight = CGSize(width: viewWidth, height: 250)
        case 40...60:
            headerHeight = CGSize(width: viewWidth, height: captionHeight + 235)
        case 61...80:
            headerHeight = CGSize(width: viewWidth, height: captionHeight + 240)
        default:
            headerHeight = CGSize(width: viewWidth, height: captionHeight + 245)
        }
        
        return headerHeight
    }
    
    //ActionSheetOptions
    func actionSheetOptions(_ option: ActionSheetOptions) {
        switch option {
        case .follow(let user):
            UserService.shared.followUser(uid: user.uid) { err, ref in
                print("Did follow user \(user.username)")
            }
        case .unfollow(let user):
            UserService.shared.unfollowUser(uid: user.uid) { err, ref in
                print("Did unfollow user \(user.username)")
            }
        case .report:
            print("Report")
        case .delete:
            print("Delete")
        }
    }
}
