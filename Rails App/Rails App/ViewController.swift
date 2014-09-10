//
//  ViewController.swift
//  Rails App
//
//  Created by Eric Williams on 9/2/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit
import CoreData

let API = "http://ancient-taiga-9634.herokuapp.com/"

var appD = UIApplication.sharedApplication().delegate as AppDelegate

class ViewController: UIViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextField!
    
    @IBAction func postNew(sender: AnyObject) {
        
        let newPostURL = API + "posts?post[title]=\(titleField.text)&post[content]=\(contentField.text)"
        
        let encodedString = newPostURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        var request = NSMutableURLRequest(URL: NSURL(string: encodedString!))
        
        request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        
        request.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            let info: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)!
            
            println(info)
            
        }
    }
    
    @IBAction func getmyPosts(sender: AnyObject) {
        
        let myPostsURL = API + "posts/mine"
        
        let request = NSMutableURLRequest(URL: NSURL(string: myPostsURL))
        
        request.setValue("zxcasdqwe", forHTTPHeaderField: "AUTH_TOKEN")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            let posts = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
            
            println(posts)
            
        }
    }
    
    @IBAction func loadCoreData(sender: AnyObject) {
        
        let allPostsURL = API + "posts"
        
        let request = NSURLRequest(URL: NSURL(string: allPostsURL))
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            let posts = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
            
            for postInfo in posts {
                
                var postObject = NSEntityDescription.insertNewObjectForEntityForName("Post", inManagedObjectContext: appD.managedObjectContext!) as NSManagedObject
                
                let title = postInfo["title"] as? String
                
                if title != nil{
                    postObject.setValue(postInfo["user"], forKey: "user")
                    postObject.setValue(postInfo["title"], forKey: "title")
                    postObject.setValue(postInfo["url"], forKey: "url")
                }
            }
        
            appD.saveContext() // save the data to core data
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.retrieveSavedCoreData()
        
    }
    
    func retrieveSavedCoreData() {
        
        // Fetch Request
        
        var fetchRequest = NSFetchRequest()
        
        var entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: appD.managedObjectContext!)
        
        fetchRequest.entity = entity
        
        var predicate = NSPredicate(format: "user = 'jo@theironyard.com'")
        
        fetchRequest.predicate = predicate
        
        var sortDescriptor = NSSortDescriptor(key: "posted_at", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var fetchedObjects = appD.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as Array!

        println(fetchedObjects.count)
        
//        for post in fetchedObjects
//        {
//        println(post)
//        }
    }
}

