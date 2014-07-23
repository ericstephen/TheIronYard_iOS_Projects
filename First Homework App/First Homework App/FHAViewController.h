//
//  FHAViewController.h
//  First Homework App
//
//  Created by Eric Williams on 7/21/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHAViewController : UIViewController

// 2 textfields (username, password) *secure*
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


// 3 labels (username = username.text, password = password.text, error = 3 error messages)

// 2 buttons (login, reset = turn fields back to empty)
- (IBAction)loginButtonClicked:(id)sender;

- (IBAction)resetTextFields:(id)sender;


// 3 buttons (no text different background colors, when you tap them, change the view background color to match the button) *UIColor*
- (IBAction)changeBackgroundRed:(id)sender;

- (IBAction)changeBackgroundGreen:(id)sender;

- (IBAction)changeBackgroundBlue:(id)sender;


@end
