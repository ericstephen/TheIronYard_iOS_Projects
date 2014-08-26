//
//  FHAViewController.m
//  First Homework App
//
//  Created by Eric Williams on 7/21/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "FHAViewController.h"

@interface FHAViewController ()

@end

@implementation FHAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClicked:(id)sender
{
    
    NSString * username = self.usernameTextField.text;
    NSString * password = self.passwordTextField.text;
    NSLog(@"Username is %@ and Password is %@", username, password);
    
    if ([self.usernameTextField.text isEqualToString:@""] && [self.passwordTextField.text isEqualToString:@""])
    {
        
        UIAlertView * noDataAlert = [[UIAlertView alloc] initWithTitle: @"Failed Login" message: @"Please Insert Username and Password" delegate: self cancelButtonTitle: @"Please Try Again" otherButtonTitles: nil];
        
        [noDataAlert show];
        
    }
    else if ([self.usernameTextField.text isEqualToString:@""])
        
    {
        UIAlertView * noUsernameAlert = [[UIAlertView alloc] initWithTitle: @"Failed Login" message: @"Please Insert Username" delegate: self cancelButtonTitle: @"Please Try Again" otherButtonTitles: nil];
        
        [noUsernameAlert show];
    }
    else if ([self.passwordTextField.text isEqualToString:@""])
        
    {
        UIAlertView * noPasswordAlert = [[UIAlertView alloc] initWithTitle: @"Failed Login" message: @"Please Insert Password" delegate:self cancelButtonTitle:@"Please Try Again" otherButtonTitles: nil];
        
        [noPasswordAlert show];
    }
    
}

- (IBAction)resetTextFields:(id)sender {
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    self.view.backgroundColor = [UIColor blackColor];
    
    
}

- (IBAction)changeBackgroundRed:(id)sender {
    self.view.backgroundColor = [UIColor redColor];
}
- (IBAction)changeBackgroundGreen:(id)sender {
    self.view.backgroundColor = [UIColor greenColor];
}
- (IBAction)changeBackgroundBlue:(id)sender {
    self.view.backgroundColor = [UIColor blueColor];
}

@end
