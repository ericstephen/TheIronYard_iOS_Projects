//
//  TLANewTweetVC.h
//  Tweet Like
//
//  Created by Eric Williams on 8/11/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLANewTweetVC : UIViewController

@property (nonatomic) NSMutableArray * tweets;

@property (weak, nonatomic) IBOutlet UITextView * tweetTextView;

@property (weak, nonatomic) IBOutlet UIImageView * swipeButton;

@property (weak, nonatomic) IBOutlet UIView *confirmButton;

@property (weak, nonatomic) IBOutlet UIView *cancelButton;


@end
