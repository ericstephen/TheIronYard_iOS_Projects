//
//  ViewController.swift
//  My Data
//
//  Created by Eric Williams on 9/2/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appD = UIApplication.sharedApplication().delegate as AppDelegate
        
        var fetchRequest = NSFetchRequest()
        
        var entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: appD.managedObjectContext)
        
        fetchRequest.entity = entity
        
        var predicate = NSPredicate(format: "user = 'jo@theironyard.com'")
        
        fetchRequest.predicate = predicate
        
        var sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var fetchedObjects = appD.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil)
        
        println(fetchedObjects)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

