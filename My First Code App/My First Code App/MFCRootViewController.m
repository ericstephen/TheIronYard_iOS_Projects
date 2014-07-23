//
//  MFCRootViewController.m
//  My First Code App
//
//  Created by Eric Williams on 7/22/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MFCRootViewController.h"

@interface MFCRootViewController () <UITextFieldDelegate>

// declare private properties & methods
// methods written here

@end

@implementation MFCRootViewController

{
    UILabel *someLabel;
    UITextField *usernameField;
    UITextField *passwordField;
    UITextField *emailField;
    UITextField *phoneField;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"init");
        
        self.view.backgroundColor = [UIColor colorWithRed:0.090f green:0.118f blue:0.369f alpha:1.0f];
        
        
    }
    return self;
}

-(void)dismissKeyboard {
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [phoneField resignFirstResponder];
    [emailField resignFirstResponder];
}

- (void)viewDidLoad
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    
    UIButton * loginButton = [[UIButton alloc] initWithFrame: CGRectMake(10.0, screenHeight - 70.0, screenWidth - 20.0, 50.0)];
    [loginButton setTitle:@"login" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor blueColor];
    loginButton.layer.cornerRadius = 10.0;
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
    [self.view addSubview: loginButton];
    

    UIButton * resetButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, screenHeight - 135, screenWidth - 20.0, 50.0)];
    [resetButton setTitle:@"reset" forState:UIControlStateNormal];
    resetButton.backgroundColor = [UIColor colorWithRed:0.082f green:0.200f blue:0.369f alpha:1.0f];
    resetButton.layer.cornerRadius = 10.0;
    [resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents: UIControlEventTouchUpInside];
    resetButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
    [self.view addSubview: resetButton];
    

    UIButton * greenButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 300.0, 50.0, 50.0)];
    greenButton.backgroundColor = [UIColor greenColor];
    greenButton.layer.cornerRadius = 25.0;
    [greenButton addTarget:self action:@selector(greenButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    greenButton.layer.borderColor = [UIColor colorWithRed:0.208f green:0.471f blue:0.141f alpha:1.0f].CGColor;
    greenButton.layer.borderWidth = 4;
    [self.view addSubview: greenButton];
    
    
    UIButton * redButton = [[UIButton alloc] initWithFrame:CGRectMake(75.0, 300.0, 50.0, 50.0)];
    redButton.backgroundColor = [UIColor redColor];
    redButton.layer.cornerRadius = 25.0;
    [redButton addTarget:self action:@selector(redButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    redButton.layer.borderColor = [UIColor colorWithRed:0.788f green:0.086f blue:0.047f alpha:1.0f].CGColor;
    redButton.layer.borderWidth = 4;
    [self.view addSubview:redButton];
    
    
    UIButton * yellowButton = [[UIButton alloc] initWithFrame:CGRectMake(135.0, 300.0, 50.0, 50.0)];
    yellowButton.backgroundColor = [UIColor yellowColor];
    yellowButton.layer.cornerRadius = 25.0;
    [yellowButton addTarget:self action:@selector(yellowButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    yellowButton.layer.borderColor = [UIColor colorWithRed:0.945f green:0.753f blue:0.035f alpha:1.0f].CGColor;
    yellowButton.layer.borderWidth = 4;
    [self.view addSubview:yellowButton];
    
    
    UIButton * orangeButton = [[UIButton alloc] initWithFrame:CGRectMake(195.0, 300.0, 50.0, 50.0)];
    orangeButton.backgroundColor = [UIColor orangeColor];
    orangeButton.layer.cornerRadius = 25.0;
    [orangeButton addTarget:self action:@selector(orangeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    orangeButton.layer.borderColor = [UIColor colorWithRed:0.945f green:0.396f blue:0.071f alpha:1.0f].CGColor;
    orangeButton.layer.borderWidth = 4;
    [self.view addSubview:orangeButton];
    
    
    UIButton * purpleButton = [[UIButton alloc] initWithFrame:CGRectMake(255.0, 300.0, 50.0, 50.0)];
    purpleButton.backgroundColor = [UIColor purpleColor];
    purpleButton.layer.cornerRadius = 25.0;
    [purpleButton addTarget:self action:@selector(purpleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    purpleButton.layer.borderColor = [UIColor colorWithRed:0.286f green:0.102f blue:0.525f alpha:1.0f].CGColor;
    purpleButton.layer.borderWidth = 4;
    [self.view addSubview:purpleButton];
    
    
    
    usernameField = [[UITextField alloc]initWithFrame:CGRectMake(10.0, 30.0, screenWidth - 20.0, 50.0)];
    
    usernameField.backgroundColor = [UIColor whiteColor];
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    usernameField.autocorrectionType = UITextAutocapitalizationTypeNone;
    usernameField.placeholder = @" username";
    usernameField.layer.cornerRadius = 10.0;
    usernameField.delegate = self;
    usernameField.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
    UIView *paddingview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    usernameField.leftView = paddingview;
    usernameField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview: usernameField];
    
    
    passwordField = [[UITextField alloc]initWithFrame:CGRectMake(10.0, 95, screenWidth - 20.0, 50.0)];
    
    passwordField.backgroundColor = [UIColor whiteColor];
    passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordField.autocorrectionType = UITextAutocapitalizationTypeNone;
    passwordField.placeholder = @" password";
    passwordField.secureTextEntry = YES;
    passwordField.layer.cornerRadius = 10.0;
    passwordField.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
    paddingview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    passwordField.leftView = paddingview;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    passwordField.delegate = self;
    [self.view addSubview: passwordField];
    
    
    emailField = [[UITextField alloc]initWithFrame:CGRectMake(10.0, 160, screenWidth - 20.0, 50.0)];
    
    emailField.backgroundColor = [UIColor whiteColor];
    emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailField.autocorrectionType = UITextAutocapitalizationTypeNone;
    emailField.placeholder = @" email";
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    emailField.layer.cornerRadius = 10.0;
    emailField.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
    paddingview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    emailField.leftView = paddingview;
    emailField.leftViewMode = UITextFieldViewModeAlways;
    emailField.delegate = self;
    [self.view addSubview: emailField];
    
    
    phoneField = [[UITextField alloc]initWithFrame:CGRectMake(10.0, 225, screenWidth - 20.0, 50.0)];
    
    phoneField.backgroundColor = [UIColor whiteColor];
    phoneField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    phoneField.autocorrectionType = UITextAutocapitalizationTypeNone;
    phoneField.placeholder = @" phone";
    phoneField.keyboardType = UIKeyboardTypePhonePad;
    phoneField.layer.cornerRadius = 10.0;
    phoneField.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
    paddingview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    phoneField.leftView = paddingview;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    phoneField.delegate = self;
    [self.view addSubview: phoneField];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"text field should return");
    [textField resignFirstResponder];
    return YES;
}
- (void)greenButtonClicked
{
    NSLog(@"Green Button Clicked");
    self.view.backgroundColor = [UIColor greenColor];
}
- (void)redButtonClicked
{
    NSLog(@"Red Button Clicked");
    self.view.backgroundColor = [UIColor redColor];
}
- (void)yellowButtonClicked
{
    NSLog(@"Yellow Button Clicked");
    self.view.backgroundColor = [UIColor yellowColor];
}
- (void)orangeButtonClicked
{
    NSLog(@"Orange Button Clicked");
    self.view.backgroundColor = [UIColor orangeColor];
}
- (void)purpleButtonClicked
{
    NSLog(@"Purple Button Clicked");
    self.view.backgroundColor = [UIColor purpleColor];
}
- (void)loginButtonClicked
{
    NSString * username = usernameField.text;
    NSString * password = passwordField.text;
    NSLog(@"Username is %@ and Password is %@", username, password);
    NSLog(@"Login Button Clicked");
}
- (void)resetButtonClicked
{
    NSLog(@"Reset Button Clicked");
    self.view.backgroundColor = [UIColor colorWithRed:0.090f green:0.118f blue:0.369f alpha:1.0f];
    usernameField.text = @"";
    passwordField.text = @"";
    emailField.text = @"";
    phoneField.text = @"";
}


@end
// leave at least one line of code after @end