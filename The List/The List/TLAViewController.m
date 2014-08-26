//
//  TLAViewController.m
//  The List
//
//  Created by Eric Williams on 8/22/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "TLAViewController.h"

@interface TLAViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TLAViewController
{
    NSMutableArray * niceArray;
    NSMutableArray * naughtyArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    niceArray = [@[@"Helper Robots", @"Some Humans"] mutableCopy];
    naughtyArray = [@[@"Invading Aliens", @"Killer Robots", @"Jaws", @"Steve Ballmer"] mutableCopy];
    
    UITabBarController * tabBarC = [[UITabBarController alloc] init];
    [self.view addSubview:tabBarC.view];
    [self addChildViewController:tabBarC];
    
    UITableViewController * niceList = [[UITableViewController alloc] init];
    niceList.title = @"Nice";
    niceList.tableView.dataSource = self;
    niceList.tableView.delegate = self;
    niceList.tableView.tag = 0;
    niceList.tabBarItem.image = [UIImage imageNamed:@"nice.png"];
    [niceList.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    UITableViewController * naughtyList = [[UITableViewController alloc] init];
    naughtyList.title = @"Naughty";
    naughtyList.tableView.dataSource = self;
    naughtyList.tableView.delegate = self;
    naughtyList.tableView.tag = 1;
    naughtyList.tabBarItem.image = [UIImage imageNamed:@"naughty.png"];
    [naughtyList.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    UITableViewController * addToList = [[UITableViewController alloc] init];
    addToList.title = @"Add To List";
    addToList.tableView.dataSource = self;
    addToList.tableView.delegate = self;
    addToList.tabBarItem.image = [UIImage imageNamed:@"addtolisticon"];
    [addToList.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    

    tabBarC.viewControllers = @[niceList, naughtyList, addToList];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
    {
        return niceArray.count;
    }

    if (tableView.tag == 1)
    {
        return naughtyArray.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray * itemArray;
    
    if (tableView.tag == 0)
    {
        itemArray = niceArray;
    }
    
    if (tableView.tag == 1)
    {
        itemArray = naughtyArray;
    }
    
    cell.textLabel.text = itemArray[indexPath.row];
    
    return cell;
}

-(BOOL)prefersStatusBarHidden {return YES;}


@end
