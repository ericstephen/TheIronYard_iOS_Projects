//
//  MCSViewController.m
//  My Cool spots
//
//  Created by Eric Williams on 8/18/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MCSViewController.h"

#import "MCSAnnotation.h"

#import "MCSTableViewController.h"

#import <MapKit/MapKit.h>

#import <CoreLocation/CoreLocation.h>


@interface MCSViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation MCSViewController
{
    MKMapView * myMapView;
    
    CLLocationManager * locationManager;
    
    UITableViewController * nameTableView;
    
    UIView * borderLine;
    
    UIWebView * webView;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"4^2"]];
    logo.frame = CGRectMake(0, 0, 50, 50);
    [self.navigationController.navigationBar addSubview:logo];
    logo.center = self.navigationController.navigationBar.center;
    
    nameTableView = [[MCSTableViewController alloc] init];
    nameTableView.tableView.frame = CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT - 300);
    
    [self.view addSubview:nameTableView.tableView];
    [self addChildViewController:nameTableView];
    
    
    myMapView = [[MKMapView alloc]init];
    myMapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    myMapView.showsUserLocation = YES;
    myMapView.delegate = self;
    
    [self.view addSubview:myMapView];
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    borderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 320, 2)];
    borderLine.layer.borderWidth = 2;
    borderLine.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.view addSubview:borderLine];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation * location in locations)
    {
        NSLog(@"%f %f", location.coordinate.latitude, location.coordinate.longitude);
        
        // call FourSquareRequest and create annotations for each venue
        
        
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1.0, 1.0));
        
        [myMapView setRegion:region animated: YES];
        
        for (int i = 0; i < 10; i++)
        {
            
            MCSAnnotation * annotation = [[MCSAnnotation alloc]init];
            
            float randomLat = (arc4random_uniform(100) - 50.0) / 100.0 + location.coordinate.latitude;
            float randomLong = (arc4random_uniform(100) - 50.0) / 100.0 + location.coordinate.longitude;
            
            CLLocationCoordinate2D randomCoordinate = CLLocationCoordinate2DMake(randomLat, randomLong);
            
            [annotation setCoordinate:randomCoordinate];
            
            CLLocation * randomLocation = [[CLLocation alloc] initWithLatitude:randomCoordinate.latitude longitude:randomCoordinate.longitude];
            
            CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
            
            [geoCoder reverseGeocodeLocation:randomLocation completionHandler:^(NSArray *placemarks, NSError *error) {
                
                for (CLPlacemark * placemark in placemarks)
                {
                    [annotation setTitle:placemark.addressDictionary[@"City"]];
                }
            }];
            
            [myMapView addAnnotation:annotation];
        
        }
    }
    
    [locationManager stopUpdatingLocation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MCSAnnotation * ann = annotation;
    
    if (mapView.userLocation.location.coordinate.latitude == ann.coordinate.latitude && mapView.userLocation.location.coordinate.longitude == ann.coordinate.longitude)
    {
        
    } else {
        
        MKAnnotationView * annotationView =[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        
        annotationView.draggable = YES;
        
        NSArray * markers = @[
                              [UIImage imageNamed:@"blue"],
                              [UIImage imageNamed:@"green"],
                              [UIImage imageNamed:@"magenta"]
                              ];
        
        int randomMarker = arc4random_uniform((int)markers.count);
        

        
        annotationView.image = markers[randomMarker];
        
        annotationView.canShowCallout = YES;
        
        UIButton *rightCallOut = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        [rightCallOut addTarget:self action:@selector(showDetailVC) forControlEvents:UIControlEventTouchUpInside];
        
        annotationView.rightCalloutAccessoryView = rightCallOut;

       return annotationView;
    }
    
    return nil;
}

- (void)showDetailVC
{
    UIViewController * detailVC = [[UIViewController alloc] init];
    
    detailVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(BOOL)prefersStatusBarHidden {return YES;}




@end
