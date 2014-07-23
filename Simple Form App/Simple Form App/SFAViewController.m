//
//  SFAViewController.m
//  Simple Form App
//
//  Created by Eric Williams on 7/21/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "SFAViewController.h"

@interface SFAViewController ()

@end

@implementation SFAViewController

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
    //SHIFT + COMMAND + 0 = HELP
    
    // get username text
    NSString * username = self.usernameTextField.text;

    // get password
    NSString * password = self.passwordTextField.text;
    
    NSLog(@"username is %@ and password is %@", username, password);
    
    // check if fields are empty
    if (0 == 1)
    {
        //false
    }
    
    if ([self.passwordTextField.text
         isEqualToString:@""])
    {
        //warn empty string
    
        UIAlertView * noUsernameAlert = [[UIAlertView alloc] initWithTitle: @"Failed Login" message: @"Please put a username in next time you try to login." delegate: self cancelButtonTitle: @"Whatever" otherButtonTitles: nil];
    
        
        [noUsernameAlert show];
        
        
        NSLog(@"username is empty...tell user to fill in");
        
    } else {
        //thank you for submitting your username
        
    }
    // try login submission success
    
    // TIY:NOTE

}
@end
