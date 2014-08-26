//
//  GFATableViewController.m
//  GitHub Friends
//
//  Created by Eric Williams on 7/24/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "GFATableViewController.h"
#import "GFATableViewCell.h"
#import "GFAViewController.h"
#import "GRAGithubRequest.h"

// 403c3612e033b9e9893de521c32ed4ffbccdff9b //

@interface GFATableViewController ()

@end

@implementation GFATableViewController
{
    NSMutableArray * githubFriends;
    
    UITextField * searchBar;
    
    UIButton * searchButton;
    
    
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        githubFriends = [@[] mutableCopy];
        
        NSArray *loadedUsers = [GRAGithubRequest loadUsers];
        
        if ([GRAGithubRequest loadUsers])
        {
            githubFriends = [loadedUsers mutableCopy];
        }
        
        self.tableView.rowHeight = 100;
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

-(void)dismissKeyboard
{
    [searchBar resignFirstResponder];
}

- (void)viewDidLoad
{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    
    
    [super viewDidLoad];
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    
    self.tableView.tableHeaderView = headerView;
    
    headerView.backgroundColor = [UIColor colorWithRed:0.996f green:0.008f blue:0.333f alpha:1.0f];
    
    searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10, 21, 250, 40)];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    searchBar.layer.borderWidth = 1;
    searchBar.placeholder = @"search";
    searchBar.font = [UIFont fontWithName:@"HelveticaNeue-light" size:25];
    searchBar.textColor = [UIColor blackColor];
    searchBar.layer.cornerRadius = 10;
    UIView *paddingview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    searchBar.leftView = paddingview;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    searchBar.autocapitalizationType = NO;
    
    [headerView addSubview:searchBar];
    
    searchButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 21, 40, 40)];
    searchButton.layer.cornerRadius = 20;
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *search = [UIImage imageNamed:@"searchButton.png"];
    [searchButton setImage:search forState:UIControlStateNormal];
    
    [headerView addSubview:searchButton];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

// - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    
//    
//    
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return githubFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[GFATableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
            reuseIdentifier:@"cell"];
    }
    
    cell.friendInfo = githubFriends[indexPath.row];
    
    cell.navigationController = self.navigationController;
    
// Configure the cell...
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Select row at %@", indexPath);
    
}

- (void)searchButtonClicked
{
    NSLog(@"Search Button Clicked");
    self.view.backgroundColor = [UIColor grayColor];
    
    NSDictionary * userInfo = [GRAGithubRequest requestUserInfo:searchBar.text];
    
    [githubFriends insertObject:userInfo atIndex:0];
    
  //  [githubFriends addObject:userInfo];
    
    [self.tableView reloadData];
    
    [GRAGithubRequest saveUsers:githubFriends];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [githubFriends removeObjectAtIndex: indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
