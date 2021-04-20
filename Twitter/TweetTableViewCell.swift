//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Phoebe Zhong  on 4/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var imgTweet: UIImageView!
    
    @IBOutlet weak var userTweet: UILabel!
    
    @IBOutlet weak var contentTweet: UILabel!
    
    
    @IBOutlet weak var retweetBTN: UIButton!
    
    
    @IBOutlet weak var likeBTN: UIButton!
    
    var isFavor: Bool = false
    var isRetweeted: Bool = false
    var selectedTweetID: Int = -1
    
    func SetFavor(_ isFavor:Bool){
        if isFavor{
            likeBTN.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
            
        }else{
            likeBTN.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
        }
    }
    
    
    func setRetweet(_ isRetweeted:Bool){
        if isRetweeted{
            retweetBTN.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetBTN.isEnabled = false
            
        }else{
            retweetBTN.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetBTN.isEnabled = true
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func LikeBtnPressed(_ sender: Any) {
        
        
        if isFavor{
            //Unlike the post
            TwitterAPICaller.client?.UnlikeTweet(tweetID: selectedTweetID, success: {
                self.SetFavor(false)
                self.isFavor = false
            }, failure: { (error) in
                print("Fail to like the post:\(error.localizedDescription)")
            })
            
        }else{
            //Like the post
            TwitterAPICaller.client?.LikeTweet(tweetID: selectedTweetID, success: {
                self.SetFavor(true)
                self.isFavor = true
            }, failure: { (error) in
                print("Fail to Unlike the post:\(error.localizedDescription)")
            })
            
        }
        
        
    }
    
    @IBAction func RtwBtnPressed(_ sender: Any) {
        TwitterAPICaller.client?.myRetweetFxn(tweetID: selectedTweetID, success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("Fail to retweet")
        })
        
    }
    
    
    
    
    
    
    
}
