//
//  TLATweetCell.h
//  Tweet Like
//
//  Created by Eric Williams on 8/11/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;

@protocol TLATweetCellDelegate;

@interface TLATweetCell : UITableViewCell

@property (nonatomic) PFObject * tweet;

@property (weak, nonatomic) IBOutlet UILabel * heartCountLabel;

@property (weak, nonatomic) IBOutlet UITextView * tweetTextView;

@property (nonatomic, assign) id <TLATweetCellDelegate> delegate;

- (IBAction)heartButtonClicked:(id)sender;

@end

@protocol TLATweetCellDelegate <NSObject>

- (void)heartsUpdated;

@end