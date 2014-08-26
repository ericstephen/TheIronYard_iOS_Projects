//
//  IWAFilteredImageVC.m
//  InstaWhat?
//
//  Created by Eric Williams on 8/25/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "IWAFilteredImageVC.h"

#import "IWAFilterVC.h"

@interface IWAFilteredImageVC ()

@end

@implementation IWAFilteredImageVC
{
    UIImageView * filterView;
    
    UITextField * pictureComment;
    
    UIButton * submit;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        filterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        filterView.contentMode = UIViewContentModeScaleAspectFill;
        filterView.clipsToBounds = YES;
        [self.view addSubview:filterView];
        
        pictureComment = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, 300, 150)];
        pictureComment.backgroundColor = [UIColor whiteColor];
        pictureComment.placeholder = @"  Add Comment";
        pictureComment.font = [UIFont fontWithName:@"Helvetica-Neue" size:14];
        [self.view addSubview:pictureComment];
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(10, 495, 300, 60)];
        submit.backgroundColor = [UIColor colorWithRed:1.000f green:0.427f blue:0.212f alpha:1.0f];
        [submit setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(submitClicked) forControlEvents: UIControlEventTouchUpInside];
        [self.view addSubview:submit];
        
    }
    return self;
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
