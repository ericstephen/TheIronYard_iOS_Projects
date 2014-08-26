//
//  MFCViewController.m
//  My Face Is Cool
//
//  Created by Eric Williams on 8/20/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MFCViewController.h"


@interface MFCViewController () 


@end

@implementation MFCViewController
{
    UIView * borderLine;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    borderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 2)];
    borderLine.layer.borderWidth = 2;
    borderLine.layer.borderColor = [UIColor colorWithRed:0.847f green:0.847f blue:0.847f alpha:1.0f].CGColor;
    [self.view addSubview:borderLine];
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView * myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Detected" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        
        [myAlertView show];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Take the photo

- (IBAction)takePhoto:(id)sender
{
    
    UIImagePickerController * photo = [[UIImagePickerController alloc] init];
    photo.delegate = self;
    photo.allowsEditing = YES;
    photo.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController: photo animated:YES completion:nil];

}

// Opens photo library

- (IBAction)photoLibrary:(id)sender
{
   
    UIImagePickerController * photo = [[UIImagePickerController alloc] init];
    photo.delegate = self;
    photo.allowsEditing = YES;
    photo.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:photo animated:YES completion:nil];
}

// Select a photo

- (void)imagePickerController:(UIImagePickerController *)photo didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * selectedImage = info[UIImagePickerControllerEditedImage];
    self.cameraScreen.image = selectedImage;
    
    [photo dismissViewControllerAnimated:YES completion:nil];
    
}

// Cancel selection

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)photo {
    
    [photo dismissViewControllerAnimated:YES completion:nil];
    
}

-(BOOL)prefersStatusBarHidden {return YES;}






@end
