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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
