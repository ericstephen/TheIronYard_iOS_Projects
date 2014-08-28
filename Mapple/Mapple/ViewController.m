//
//  ViewController.m
//  Mapple
//
//  Created by Eric Williams on 8/28/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation ViewController
{
     MKMapView * mapView;
     CLLocationManager * locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [locationManager requestAlwaysAuthorization];
    
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height/2.0)];
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    mapView.userTrackingMode = YES;
    [self.view addSubview:mapView];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation * location in locations)
    {
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1.0, 1.0));
        
        [mapView setRegion:region animated:YES];
        }
}

-(BOOL)prefersStatusBarHidden {return YES;}

@end
