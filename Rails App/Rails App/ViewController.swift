//
//  ViewController.swift
//  Rails App
//
//  Created by Eric Williams on 9/2/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit

let API = "http://ancient-taiga-9634.herokuapp.com/"

class ViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextField!
    
    @IBAction func postNew(sender: AnyObject) {
    }
    
    
    @IBAction func getMyPosts(sender: AnyObject) {
    }
    
    
    @IBAction func getAllPosts(sender: AnyObject) {
        
        let allPostsURL = API + "posts"
        
        let request = NSURLRequest(URL: NSURL(string: allPostsURL))
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            let posts = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
            
            println(posts)
        }
    }

    
    
                            
    override func viewDidLoad() {

        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

