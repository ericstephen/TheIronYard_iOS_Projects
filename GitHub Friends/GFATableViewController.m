//
//  GFATableViewController.m
//  GitHub Friends
//
//  Created by Eric Williams on 7/24/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "GFATableViewController.h"
#import "GFATableViewCell.h"

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
        
        githubFriends = [@[
        @{
            @"login": @"renecandelier",
            @"id": @4494771,
            @"avatar_url": @"https://avatars.githubusercontent.com/u/4494771?",
            @"gravatar_id": @"01115a6dcc0c2129fa822e877e8a5e7a",
            @"url": @"https://api.github.com/users/renecandelier",
            @"html_url": @"https://github.com/renecandelier",
            @"followers_url": @"https://api.github.com/users/renecandelier/followers",
            @"following_url": @"https://api.github.com/users/renecandelier/following{/other_user}",
            @"gists_url": @"https://api.github.com/users/renecandelier/gists{/gist_id}",
            @"name": @"Rene Candelier",
            @"company": @"Novus Mobile",
            @"blog": @"",
            @"location": @"United States",
            @"email": @"renecandelier@gmail.com",
            @"followers": @1,
            @"following": @2,},
        @{
            @"login": @"ssniteman",
            @"id": @4793213,
            @"avatar_url": @"https://avatars.githubusercontent.com/u/4793213?",
            @"gravatar_id": @"c3064d7a4da0dcea13f84d83b6eafac4",
            @"url": @"https://api.github.com/users/ssniteman",
            @"html_url": @"https://github.com/ssniteman",
            @"followers_url": @"https://api.github.com/users/ssniteman/followers",
            @"following_url": @"https://api.github.com/users/ssniteman/following{/other_user}",
            @"gists_url": @"https://api.github.com/users/ssniteman/gists{/gist_id}",
            @"name": @"Shane Sniteman",
            @"company": @"",
            @"blog": @"",
            @"location": @"Atlanta, GA",
            @"email": @"ssniteman@gmail.com",
            @"followers": @22,
            @"following": @35,},
        @{
            @"login": @"npeterson213",
            @"id": @8224722,
            @"avatar_url": @"https://avatars.githubusercontent.com/u/8224722?",
            @"gravatar_id": @"62343ab9edebc48399b0e4095f42f14f",
            @"url": @"https://api.github.com/users/npeterson213",
            @"html_url": @"https://github.com/npeterson213",
            @"followers_url": @"https://api.github.com/users/npeterson213/followers",
            @"following_url": @"https://api.github.com/users/npeterson213/following{/other_user}",
            @"name": @"Nick Peterson",
            @"location": @"Atlanta, GA",
            @"followers": @0,
            @"following": @0,},
        @{
            @"login": @"dmerrill88",
            @"id": @8224723,
            @"avatar_url": @"https://avatars.githubusercontent.com/u/8224723?",
            @"gravatar_id": @"2e445c7b6aa2a73de0f369436515f7e6",
            @"url": @"https://api.github.com/users/dmerrill88",
            @"html_url": @"https://github.com/dmerrill88",
            @"followers_url": @"https://api.github.com/users/dmerrill88/followers",
            @"following_url": @"https://api.github.com/users/dmerrill88/following{/other_user}",
            @"gists_url": @"https://api.github.com/users/dmerrill88/gists{/gist_id}",
            @"name": @"Daniel Merrill",
            @"location": @"United States",
            @"followers": @0,
            @"following": @0,},
        @{
            @"login": @"JaimeConnor",
            @"id": @8224727,
            @"avatar_url": @"https://avatars.githubusercontent.com/u/8224727?",
            @"gravatar_id": @"c095fcff9ec739118aec1f807107f07f",
            @"url": @"https://api.github.com/users/JaimeConnor",
            @"html_url": @"https://github.com/JaimeConnor",
            @"followers_url": @"https://api.github.com/users/JaimeConnor/followers",
            @"following_url": @"https://api.github.com/users/JaimeConnor/following{/other_user}",
            @"gists_url": @"https://api.github.com/users/JaimeConnor/gists{/gist_id}",
            @"name": @"Jaime Connor",
            @"location": @"Atlanta, Georgia",
            @"followers": @0,
            @"following": @0,}
        
        ] mutableCopy];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    
    self.tableView.tableHeaderView = headerView;
    
    searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 250, 40)];
    searchBar.backgroundColor = [UIColor grayColor];
    searchBar.layer.borderColor = [UIColor blackColor].CGColor;
    searchBar.layer.borderWidth = 1;
    searchBar.placeholder = @"search";
    searchBar.font = [UIFont fontWithName:@"HelveticaNeue-light" size:25];
    searchBar.textColor = [UIColor whiteColor];
    UIView *paddingview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    searchBar.leftView = paddingview;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:searchBar];
    
    searchButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 30, 40, 40)];
    searchButton.backgroundColor = [UIColor grayColor];
    [searchButton setTitle:@"GO" forState:UIControlStateNormal];
    searchButton.font = [UIFont fontWithName:@"HelveticaNeue-light" size:18];
    searchButton.layer.cornerRadius = 20;
    
    [self.view addSubview:searchButton];
    
    
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
    
// Configure the cell...
    
    
    
    return cell;
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
