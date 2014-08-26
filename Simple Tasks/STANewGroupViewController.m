//
//  STANewGroupViewController.m
//  Simple Tasks
//
//  Created by Eric Williams on 7/30/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "STANewGroupViewController.h"

#import "STAGroupsTableViewController.h"

@interface STANewGroupViewController ()

@end

@implementation STANewGroupViewController
{
    UITextField *groupNameField;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    groupNameField = [[UITextField alloc] initWithFrame: CGRectMake(20, 25, SCREEN_WIDTH - 40, 40)];
    groupNameField.backgroundColor = [UIColor whiteColor];
    UIColor *color = [UIColor blackColor];
    groupNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"group name" attributes:@{NSForegroundColorAttributeName: color}];
    groupNameField.font = [UIFont fontWithName: @"HelveticaNeue-light" size:30];
    
    [groupNameField becomeFirstResponder];
    
    [self.view addSubview:groupNameField];
    
    
    UITextField *borderLine =[[UITextField alloc] initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH - 40, 1)];
    borderLine.layer.borderColor = [UIColor blackColor].CGColor;
    borderLine.layer.borderWidth = 1;
    
    [self.view addSubview:borderLine];
    
    
    UIButton * saveEntry = [[UIButton alloc] initWithFrame:CGRectMake(178, 90, 110, 110)];
    saveEntry.layer.cornerRadius = 40;
    saveEntry.backgroundColor = [UIColor whiteColor];
    [saveEntry addTarget:self action:@selector(saveEntryClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *groupSearch = [UIImage imageNamed:@"group_save.png"];
    [saveEntry setImage:groupSearch forState:UIControlStateNormal];
    saveEntry.adjustsImageWhenHighlighted = NO;
    
    [self.view addSubview:saveEntry];
    
    
    UIButton * cancelEntry = [[UIButton alloc] initWithFrame:CGRectMake(32, 90, 110, 110)];
    cancelEntry.layer.cornerRadius = 40;
    cancelEntry.backgroundColor = [UIColor whiteColor];
    [cancelEntry addTarget:self action:@selector(cancelEntryClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *groupCancel = [UIImage imageNamed:@"group_close.png"];
    cancelEntry.adjustsImageWhenHighlighted = NO;
    [cancelEntry setImage:groupCancel forState:UIControlStateNormal];
    
    [self.view addSubview:cancelEntry];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveEntryClicked
{
    [self.groups addObject:[@{
                              @"name": groupNameField.text,
                              @"items": [@[] mutableCopy]
                              } mutableCopy]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //[self cancelGroupClicked]; **alternative code to dismissViewController above**
}

-(void)cancelEntryClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (BOOL)prefersStatusBarHidden {return YES;}

@end
