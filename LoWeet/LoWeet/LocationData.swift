//
//  locationData.swift
//  LoWeet
//
//  Created by Eric Williams on 9/15/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

// Add STTwitter framework to Xcode project (found on Github)  -- CHECK
// add touch to map to drop a pin and show a "new tweet location" form like the plus button
// make pins draggable and chance location for item when dropped
// make a test Twitter account and sign in on your device
// run some test tweets using STTwitter in your app

import UIKit

let _locationData : LocationData = {
    
    LocationData()
    
}()

class LocationData: NSObject {
    
    var locations: [[String:AnyObject]] = []
    
    class func mainData() -> LocationData {
        
        return _locationData
    }
    
    func addLocation(location:[String:AnyObject]) {
        
        self.locations += [location]
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.postNotificationName("tweetLocationsUpdated", object: nil, userInfo: nil)
    }
   
}
