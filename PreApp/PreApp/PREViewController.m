//
//  PREViewController.m
//  PreApp
//
//  Created by Eric Williams on 7/21/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "PREViewController.h"

@interface PREViewController ()

@end

@implementation PREViewController

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

- (IBAction)buttonClicked:(id)sender
{
    NSLog(@"button was clicked");
    
    self.textLabel.text = @"button was clicked";
}
@end
