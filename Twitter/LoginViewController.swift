//
//  LoginViewController.swift
//  Twitter
//
//  Created by Phoebe Zhong  on 4/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    

    @IBAction func loginButton(_ sender: Any) {
        
        let ApiReferenceURL = "https://api.twitter.com/oauth/request_token"

        TwitterAPICaller.client?.login(url: ApiReferenceURL, success: {
            
            UserDefaults.standard.set(true, forKey: "userLoggedin")
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }, failure: { (Error) in
            print(Error.localizedDescription)
        })

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //if user already logged in, go straight to home page
        if UserDefaults.standard.bool(forKey: "userLoggedin"){
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
