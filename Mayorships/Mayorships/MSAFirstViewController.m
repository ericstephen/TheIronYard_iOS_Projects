//
//  MSAFirstViewController.m
//  Mayorships
//
//  Created by Eric Williams on 8/19/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MSAFirstViewController.h"

#import "MSARequest.h"

#import <CoreLocation/CoreLocation.h>


@interface MSAFirstViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@end

@implementation MSAFirstViewController
{
    NSArray * mayorships;
    
    CLLocationManager * locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mayorList.rowHeight = 60;
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    self.mayorList.dataSource = self;
    self.mayorList.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location = locations[0];
    
    [locationManager stopUpdatingLocation];
    
    //    mayorships = [MSARequest findMayorshipsWithLocation:location];
    
    [MSARequest findMayorshipsWithLocation:location completion:^(NSArray * mayors)
     {
         mayorships = mayors;
         [self.mayorList reloadData];
     }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mayorships.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.mayorList dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * mayor = mayorships[indexPath.row];
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://irs2.4sqi.net/img/user/100x100%@", mayor[@"user"][@"photo"][@"suffix"]]];
    
    NSString * documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString * filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", mayor[@"user"][@"id"]]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (!fileExists)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            [data writeToFile:filePath atomically:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imageView.image = [UIImage imageWithData:data];
                
            });
            
        });
        
    } else {
        
        cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    }
    
    cell.textLabel.text = mayor[@"user"][@"firstName"];
    
    //    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 215, 5, 50, 50)];
    //    button.layer.cornerRadius = 25;
    //    button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:data]];
    //    [cell addSubview:button];
    
    
    return cell;
}

-(BOOL)prefersStatusBarHidden {return YES;}


@end
