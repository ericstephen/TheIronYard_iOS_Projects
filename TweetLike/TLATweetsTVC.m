//
//  TLATweetsTVC.m
//  Tweet Like
//
//  Created by Eric Williams on 8/11/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "TLATweetsTVC.h"

#import "TLATweetCell.h"

#import "TLANewTweetVC.h"

#import "AFNetworking.h"

#import <Parse/Parse.h>

@interface TLATweetsTVC () <TLATweetCellDelegate>

@end

@implementation TLATweetsTVC
{
    NSMutableArray * tweetLikes;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Custom initialization

        [Parse setApplicationId:@"L1IPX1pFO1iLCRbZ3Hu4o7LCwlkpktqFTKI1zzRt" clientKey:@"Jjgc6YFyzuo734oav544IZKAPawTozNtNU12N6Wg"];
    
        tweetLikes = [@[] mutableCopy];
        
        AFHTTPRequestOperationManager * requestManager = [[AFHTTPRequestOperationManager alloc] init];
        
        [requestManager GET:@"http://jo2.co/twitter.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            /////////////////
            /////////////////   NEW WAY
            /////////////////
            
            
            PFQuery *queryAll = [PFQuery queryWithClassName: @"Tweet"];
            
            [queryAll findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                //                tweetLikes = objects;
                
                for (NSDictionary * tweet in responseObject)
                {
                    BOOL tweetInfoFound = NO;
                    
                    for (PFObject *tweetInfo in objects)
                    {
                        if ([tweet[@"id"] isEqual:tweetInfo[@"id"]])
                        {
                            tweetInfoFound = YES;
                            
                            [tweetLikes addObject:tweetInfo];
                        }
                    }
                    
                    if (!tweetInfoFound)
                    {
                        PFObject *newTweetInfo = [PFObject objectWithClassName:@"Tweet"];
                        
                        [newTweetInfo setObject: tweet[@"id"] forKey:@"id"];
                        [newTweetInfo setObject:tweet[@"text"] forKey:@"text"];
                        [newTweetInfo setObject:@0 forKey:@"hearts"];
                        
                        [newTweetInfo saveInBackground];
                        [tweetLikes addObject:newTweetInfo];
                    }
                }
                
                
                [self.tableView reloadData];
                
            }];
            
            
            /////////////////
            /////////////////   OLD WAY
            /////////////////
            
            
            //            for (NSDictionary * tweet in responseObject)
            //            {
            //
            //                PFQuery * query = [PFQuery queryWithClassName:@"Tweet"];
            //
            //                [query whereKey:@"id" equalTo: tweet[@"id"]];
            //
            //                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            //
            //                    //            NSLog(@"%@", objects);
            //
            //                    if (objects.count > 0)
            //                    {
            //
            //                    } else {
            //
            //                        PFObject * tweetInfo = [PFObject objectWithClassName:@"Tweet"];
            //                        [tweetInfo setObject: tweet[@"id"] forKey:@"id"];
            //                        [tweetInfo setObject:tweet[@"text"] forKey:@"text"];
            //                        [tweetInfo setObject:@0 forKey:@"hearts"];
            //
            //                        [tweetInfo saveInBackground];
            //
            //                    }
            //                }];
            //
            //            }
            //                PFQuery *queryAll = [PFQuery queryWithClassName: @"Tweet"];
            //
            //                [queryAll findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            //
            //                    tweets = objects;
            //
            //                    [self.tableView reloadData];
            //
            //                }];
            
            //                [tweets addObject:[@{
            //                                     @"id" : tweet [@"id"],
            //                                     @"text" : tweet [@"text"],
            //                                     @"hearts" : @0
            //
            //                                     } mutableCopy]];
            //
            
            //            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"header_logo"]];
    
    logo.frame = CGRectMake(0, 0, 121, 24);
    
    [self.navigationController.navigationBar addSubview:logo];
    logo.center = self.navigationController.navigationBar.center;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweetLikes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLATweetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFObject * tweet = tweetLikes[indexPath.row];
    
    cell.tweetTextView.text = tweet [@"text"];
    
    cell.heartCountLabel.text = (tweet[@"hearts"]) ? [NSString stringWithFormat:@"%@", tweet[@"hearts"]] : @"0";
    
    cell.delegate = self;
    cell.tweet = tweet;
    
    return cell;
}

-(void)heartsUpdated
{
    [self.tableView reloadData];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showNewTweetVC"])
    {
        TLANewTweetVC * newTweetVC = segue.destinationViewController;
        
        newTweetVC.tweets = tweetLikes;
    }
}

@end
