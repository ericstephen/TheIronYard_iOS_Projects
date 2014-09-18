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
import CoreLocation

let _locationData : LocationData = {
    
    LocationData()
    
}()

class LocationData: NSObject, CLLocationManagerDelegate {
    
    var tweetLocations: [[String:AnyObject]] = []
    var foundLocations: [[String:AnyObject]] = []
    
    class func mainData() -> LocationData {
        
        return _locationData
    }
    
    func addLocation(location:[String:AnyObject]) {
        
        self.tweetLocations += [location]
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.postNotificationName("tweetLocationsUpdated", object: nil, userInfo: nil)
    }
    
     /////////// LOCATION INFO ///////////
    
    let locationManager = CLLocationManager()
    
    override init() {
        
        super.init()
        
      self.locationManager.delegate = self
        
      self.locationManager.distanceFilter = 40.0
        
      self.locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        for location in locations as [CLLocation] {
            
            for tweetLocation in self.tweetLocations {
                
                var tweetLocationPoint = CLLocation(latitude: tweetLocation["latitude"]! as CLLocationDegrees, longitude: tweetLocation["longitude"]! as CLLocationDegrees)
                
                location.distanceFromLocation(tweetLocationPoint)
                
                var distance1 = location.distanceFromLocation(tweetLocationPoint)
                var distance2 = self.checkDistanceBetweenLocations(location, location2: tweetLocationPoint)
                
                println(distance1)
                println(distance2)
                
                if distance2 < 50.0 {
                    
                    // post tweet
                }
            }
            
        }
        
    }
    
    func checkDistanceBetweenLocations(location1: CLLocation, location2: CLLocation) -> Double {
        
        let DEG_TO_RAD = 0.017453292519943295769236907684886
        let EARTH_RADIUS_IN_METERS = 6372797.560856
        
        let latitudeArc  = (location1.coordinate.latitude - location2.coordinate.longitude) * DEG_TO_RAD
        let longitudeArc = (location1.coordinate.latitude - location2.coordinate.longitude) * DEG_TO_RAD

        var latitudeH = sin(latitudeArc * 0.5)
        latitudeH *= latitudeH
        
        var longitudeH = sin(longitudeArc * 0.5)
        longitudeH *= longitudeH
        
        let tmp = cos(location1.coordinate.latitude * DEG_TO_RAD) * cos(location2.coordinate.longitude * DEG_TO_RAD)
        
        return EARTH_RADIUS_IN_METERS * 2.0 * asin(sqrt(latitudeH + tmp * longitudeH))
        
    }
}
