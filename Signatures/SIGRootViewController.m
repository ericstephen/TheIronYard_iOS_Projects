//
//  SIGRootViewController.m
//  Signatures
//
//  Created by Eric Williams on 8/13/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "SIGRootViewController.h"

#import "SIGlistTableViewController.h"

#import "SIGDrawViewController.h"

@interface SIGRootViewController ()

@end

@implementation SIGRootViewController
{
    UIButton * saveButton;
    UIButton * cancelButton;
    NSMutableArray * signatures;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SIGlistTableViewController * listTVC = [[SIGlistTableViewController alloc]init];
    
    listTVC.tableView.frame = CGRectMake (0,200,SCREEN_WIDTH,368);
    
    [self.view addSubview:listTVC.tableView];
    
    
    SIGDrawViewController * drawVC = [[SIGDrawViewController alloc] init];
    
    drawVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    
    [self.view addSubview:drawVC.view];
    
    
    saveButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 205, 130, 36)];
    saveButton.backgroundColor = [UIColor colorWithRed:0.000f green:0.965f blue:0.592f alpha:1.0f];
    saveButton.layer.cornerRadius = 18;
    saveButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
    
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(165, 205, 130, 36)];
    cancelButton.backgroundColor = [UIColor colorWithRed:1.000f green:0.188f blue:0.118f alpha:1.0f];
    cancelButton.layer.cornerRadius = 18;
    cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:20];
    [cancelButton setTitle:@"Clear" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clearButtonClicked) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)saveButtonClicked
{
    NSLog(@"Save Button Clicked");
}

- (void)clearButtonClicked
{
    
    [signatures removeAllObjects];
    [self.view setNeedsDisplay];
    NSLog(@"Clear Button Clicked");
}

-(BOOL)prefersStatusBarHidden {return YES;}


@end
