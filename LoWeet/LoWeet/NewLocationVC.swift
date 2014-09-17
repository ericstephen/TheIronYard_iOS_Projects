//
//  NewLocationVC.swift
//  LoWeet
//
//  Created by Eric Williams on 9/15/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

import UIKit
import CoreLocation

class NewLocationVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    let locationManager = CLLocationManager()
    
    var currentCoordinate: CLLocationCoordinate2D!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            
            locationManager.requestWhenInUseAuthorization()

        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        for location in locations {
            
           currentCoordinate = (location as CLLocation).coordinate
            
        }
        
    }
    
    @IBAction func saveNewLocation() {
        
        LocationData.mainData().addLocation([
                                                "latitude" : self.currentCoordinate.latitude,
                                                "longitude" : self.currentCoordinate.longitude,
                                                "tweet" : self.tweetTextView.text
                                                    ])
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
