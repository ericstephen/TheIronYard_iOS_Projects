//
//  IWAFilteredImageVC.m
//  InstaWhat?
//
//  Created by Eric Williams on 8/25/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "IWAFilteredImageVC.h"

#import "IWAFilterVC.h"

#import "Parse/Parse.h"

@interface IWAFilteredImageVC () <UITextViewDelegate>

@end

@implementation IWAFilteredImageVC
{
    UIImageView * filterView;
    
    UITextView * pictureComment;
    
    UIButton * submit;
    
    UIView * captionHolder;
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        filterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        filterView.contentMode = UIViewContentModeScaleAspectFill;
        filterView.clipsToBounds = YES;
        [self.view addSubview:filterView];
    
        
        captionHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 310, 320, [UIScreen mainScreen].bounds.size.height - 310)];
        captionHolder.backgroundColor = [UIColor lightGrayColor];
        captionHolder.layer.borderWidth = 10;
        captionHolder.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.view addSubview:captionHolder];
    
        
        pictureComment = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, captionHolder.frame.size.height - 70)];
        pictureComment.backgroundColor = [UIColor whiteColor];
        pictureComment.delegate = self;
        pictureComment.font = [UIFont fontWithName:@"Helvetica-Neue" size:14];
        
        [captionHolder addSubview:pictureComment];
        
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(20, captionHolder.frame.size.height - 60, 280, 40)];
        submit.backgroundColor = [UIColor colorWithRed:1.000f green:0.427f blue:0.212f alpha:1.0f];
        [submit setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(submitClicked) forControlEvents: UIControlEventTouchUpInside];
        
        [submit addTarget:self action:@selector(saveFace) forControlEvents:UIControlEventTouchUpInside];
        
        [captionHolder addSubview:submit];
        
    }
    return self;
}

- (void)saveFace
{
    PFObject * face = [PFObject objectWithClassName:@"Faces"];
    
    [face setObject:pictureComment.text forKey:@"text"];
    
    NSData * data = UIImagePNGRepresentation(filterView.image);
    
    PFFile * file = [PFFile fileWithData:data];
    
    [face setObject:file forKey:@"image"];
    
    [face saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        
        [nc postNotificationName:@"faceSaved" object:nil];
        
    }];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        
        captionHolder.center = CGPointMake(captionHolder.center.x, captionHolder.center.y - 250);
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.843f green:0.863f blue:0.882f alpha:1.0f];
    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view.layer.borderWidth = 6;

}

- (void)setFilteredImage:(UIImage *)filteredImage
{
    _filteredImage = filteredImage;
    
    filterView.image = filteredImage;

}

-(void)dismissKeyboard
{
    [pictureComment resignFirstResponder];
}


-(void)submitClicked
{
    
}

- (void)textWithImage;
{
    
}

@end
