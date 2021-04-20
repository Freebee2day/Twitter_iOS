//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Phoebe Zhong  on 4/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeTableViewController: UITableViewController {
    
    
    var tweetCollection = [NSDictionary]()
    var numOfTweet : Int!
    
    let myRefreshControl = UIRefreshControl()
    
    
    @objc func myTweetFetchingFxn() {
        let myHomeTweetURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numOfTweet = 15
        
        let myParameter = ["count": numOfTweet]
        
        //let myParameter = ["count": 10, "since_id": xxx, "max_id": 222]
        //check documentation to see how you want to filter out with parameters.
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myHomeTweetURL, parameters: myParameter, success: { (myresult:[NSDictionary]) in
            //first clear up array container
            self.tweetCollection.removeAll()
        
            for singleTweet in myresult{
                self.tweetCollection.append(singleTweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (error) in
            print("Fail to retrieve tweets: \(error.localizedDescription)")
        })
    }
    
    
    func myLoadMoreTweetsFxn(){
        let myHomeTweetURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numOfTweet += 10
        let myParameter = ["count": numOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myHomeTweetURL, parameters: myParameter, success: { (myresult:[NSDictionary]) in
            //first clear up array container
            self.tweetCollection.removeAll()
        
            for singleTweet in myresult{
                self.tweetCollection.append(singleTweet)
            }
            
            self.tableView.reloadData()
            //self.myRefreshControl.endRefreshing()   no need to refresh if we are pulling more old tweets from the bottom
            
        }, failure: { (error) in
            print("Fail to retrieve tweets: \(error.localizedDescription)")
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //when we get to the end of the table, we want to load more tweets by calling the myLoadMoreTweetsFxn
        if indexPath.row + 1 == tweetCollection.count{
            myLoadMoreTweetsFxn()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.myTweetFetchingFxn()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for pull to refresh
        myRefreshControl.addTarget(self, action: #selector(myTweetFetchingFxn), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        
        
        //tableView.rowHeight = 300

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetCollection.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        myCell.contentTweet.text = tweetCollection[indexPath.row]["text"] as? String
        
        
        //both user name and user profile image is a dictionary within the tweet dictionary
        //so need to store the user as myUser dictionary first
        let myUser = tweetCollection[indexPath.row]["user"] as! NSDictionary
        myCell.userTweet.text = myUser["name"] as? String
        
        let tweetImgString = myUser["profile_image_url_https"] as! String
        let tweetImgURL = URL(string: tweetImgString)!
        myCell.imgTweet.af_setImage(withURL: tweetImgURL)
        
        let tweetLiked = tweetCollection[indexPath.row]["favorited"] as! Bool
        myCell.SetFavor(tweetLiked)
        
        let tweetShared = tweetCollection[indexPath.row]["retweeted"] as! Bool
        myCell.setRetweet(tweetShared)
        
        myCell.selectedTweetID = tweetCollection[indexPath.row]["id"] as! Int
        
        return myCell
    }
    
    
    
    @IBAction func LogoutBTN(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedin")
        
    }
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
