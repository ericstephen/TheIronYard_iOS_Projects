//
//  MFLTableViewController.m
//  List App
//
//  Created by Eric Williams on 7/23/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MFLTableViewController.h"

@interface MFLTableViewController ()

@property (nonatomic) NSArray * infoList;

@end

@implementation MFLTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

        
        self.infoList = @[@{@"day": @"Monday",@"color": [UIColor redColor], @"name": @"Arthur", @"size": @20},
                          @{@"day": @"Tuesday", @"color":[UIColor orangeColor], @"name": @"Daniel", @"size": @22},
                          @{@"day": @"Wednesday", @"color":[UIColor yellowColor], @"name": @"David", @"size": @24},
                          @{@"day": @"Thursday", @"color":[UIColor greenColor], @"name": @"Eric", @"size": @24},
                          @{@"day": @"Friday", @"color":[UIColor blueColor], @"name": @"Heidi", @"size": @26},
                          @{@"day": @"Saturday", @"color":[UIColor purpleColor], @"name": @"Jaime", @"size": @28},
                          @{@"day": @"Sunday", @"color":[UIColor grayColor], @"name": @"Jeff", @"size": @30}];
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoList.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier: @"cell"];
    
    
    NSDictionary * infoItem = self.infoList[indexPath.row];

    cell.textLabel.text = infoItem [@"day"];
    cell.detailTextLabel.text = infoItem [@"name"];
    cell.backgroundColor = infoItem [@"color"];
    cell.textLabel.font = [UIFont systemFontOfSize:[infoItem [@"size"] intValue]];
    
    cell.textLabel.font = [UIFont fontWithName: @"HelveticaNeue-Bold" size: [infoItem [@"size"] intValue]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=75;
    
  

    return height;
}
@end
