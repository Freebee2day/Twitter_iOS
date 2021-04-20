//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Phoebe Zhong  on 4/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var TweetInput: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TweetInput.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelComposeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func PostBtn(_ sender: Any) {
        if (!TweetInput.text.isEmpty){
            TwitterAPICaller.client?.postMyTweet(tweetString: TweetInput.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Fail to post tweet: \(error.localizedDescription)")
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            print("Tweet content cannot be empty")
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
