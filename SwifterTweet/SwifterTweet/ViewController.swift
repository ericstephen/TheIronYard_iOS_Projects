//
//  ViewController.swift
//  SwifterTweet
//
//  Created by Heidi Proske on 9/16/14.
//  Copyright (c) 2014 Heidi Proske. All rights reserved.
//

import UIKit
import SwifteriOS
import Accounts
import Social

class ViewController: UIViewController {
    
    var swifter = Swifter(
        consumerKey: "",
        consumerSecret: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (succeeded: Bool, error: NSError!) -> Void in
            
            if succeeded {
                
                let twitterAccounts = accountStore.accountsWithAccountType(accountType)
                
                println(twitterAccounts)
                
                for tAccount in twitterAccounts {
                    
                    let tA = tAccount as ACAccount
                    
                    println(tA.username)
                    println(tA.accountDescription)
                    println(tA.identifier)
                    
                }
                
                let twitterAccount = twitterAccounts[0] as ACAccount
                
                self.swifter = Swifter(account: twitterAccount)
                
                self.swifter.postStatusUpdate("I'm posting from an app I build with the new Swifter framework #iOS #swift @Joalbright", inReplyToStatusID: nil, lat: nil, long: nil, placeID: nil, displayCoordinates: false, trimUser: true, success: { (status) -> Void in
                    
                    
                }, failure: { (error) -> Void in
                    
                })
                
                
//                self.swifter.getStatusesHomeTimelineWithCount(5, sinceID: nil, maxID: nil, trimUser: true, contributorDetails: true, includeEntities: true, success: { (statuses) -> Void in
//                    
//                    println(statuses)
//                    
//                }, failure: { (error) -> Void in
//                    
//                    println(error)
//                })
                
//                println(accounts)
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

