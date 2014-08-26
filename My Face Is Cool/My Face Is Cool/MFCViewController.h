//
//  MFCViewController.h
//  My Face Is Cool
//
//  Created by Eric Williams on 8/20/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@interface MFCViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)takePhoto:(id)sender;

- (IBAction)photoLibrary:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView * cameraScreen;

@end
