//
//  GFATableViewCell.m
//  GitHub Friends
//
//  Created by Eric Williams on 7/24/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "GFATableViewCell.h"

@implementation GFATableViewCell
{
    UILabel * friendName;
    
    UIImageView * friendImage;
    
    UILabel * friendLocation;
    
    UIButton * gistSite;
    
    UITextField * searchBar;
    
    UIButton * profileButton;
    
    UILabel * gistCount;
    
    UIButton * followCountUp;
    
    UIButton * followCountDown;
    
    UILabel * leader;
    
    UILabel * justFriends;
    
    UILabel * follower;
    
    UILabel * count;
    
    UILabel * countUp;
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        
        
        friendName = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200, 40)];
        friendName.font = [UIFont fontWithName:@"HelveticaNeue-Ultralight" size:20];
        friendName.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:friendName];
        
        
        friendImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 115, 115)];

        
        [self.contentView addSubview:friendImage];
        
        friendLocation = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 200, 40)];
        friendLocation.font = [UIFont fontWithName:@"HelveticaNeue-light" size:15];
        friendLocation.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:friendLocation];
        
    
        gistSite = [[UIButton alloc] initWithFrame:CGRectMake(250, 80, 60, 24)];
        gistSite.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        gistSite.layer.borderWidth = 1;
        gistSite.layer.borderColor = [UIColor whiteColor].CGColor;
        gistSite.layer.cornerRadius = 12;
        gistSite.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:13];
        [gistSite setTitle:@"GIST" forState:UIControlStateNormal];
        
        [self.contentView addSubview:gistSite];
        
        
        gistCount = [[UILabel alloc] initWithFrame:CGRectMake(235, 80, 24, 24)];
        gistCount.backgroundColor = [UIColor whiteColor];
        gistCount.layer.cornerRadius = 12;
        gistCount.layer.masksToBounds = YES;
        gistCount.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:gistCount];
        
        
        profileButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 10, 24, 24)];
        UIImage *detailArrow = [UIImage imageNamed:@"profileArrow.png"];
        [profileButton setImage:detailArrow forState:UIControlStateNormal];
        
        [self.contentView addSubview:profileButton];
        
    }
    return self;
}

- (void) setFriendInfo:(NSDictionary *)friendInfo
{
    _friendInfo = friendInfo;
    
    NSURL * url = [NSURL URLWithString:friendInfo[@"avatar_url"]];
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    UIImage * image = [UIImage imageWithData:data];
    
    
    friendImage.image = image;
    
    friendName.text = friendInfo[@"name"];
    
    friendLocation.text = friendInfo[@"location"];
    
    
    NSString * gists = [NSString stringWithFormat:@"%@", friendInfo[@"public_gists"]];
    
    gistCount.text = gists;
    
    
    
       int ratio = [friendInfo[@"followers"] intValue] - [friendInfo[@"following"] intValue];
    
    if (ratio > 0)
    {
        count = [[UILabel alloc]initWithFrame:CGRectMake(118.0, 65, 20.0, 20)];
        count.layer.cornerRadius = 10;
        count.layer.masksToBounds= 1;
        count.backgroundColor = [UIColor colorWithRed:0.184f green:0.184f blue:0.184f alpha:1.0f];
        count.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:11];
        count.textColor = [UIColor whiteColor];
        count.textAlignment= NSTextAlignmentCenter;
        count.layer.borderWidth = 0.5;
        count.layer.borderColor = [[UIColor whiteColor]CGColor];
        count.text = [NSString stringWithFormat:@"%d", abs(ratio)];
        
        [self.contentView addSubview:count];
        
        
        followCountUp = [UIButton buttonWithType:UIButtonTypeCustom];
        followCountUp.frame = CGRectMake(100, 80, 24, 24);
        [followCountUp setBackgroundImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:followCountUp];
        
        
        leader = [[UILabel alloc]initWithFrame:CGRectMake(148.0, 65, 40.0, 20)];
        leader.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        leader.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:10];
        leader.textColor = [UIColor colorWithRed:0.196f green:0.973f blue:0.749f alpha:1.0f];
        leader.text = @"Leader";
        leader.textAlignment= NSTextAlignmentCenter;
        
        [self.contentView addSubview:leader];
        
    }
    
    else if (ratio < 0)
    {
        count = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 80, 24, 24)];
        count.layer.cornerRadius = 12;
        count.layer.masksToBounds= 1;
        count.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        count.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:11];
        count.textColor = [UIColor colorWithRed:0.996f green:0.008f blue:0.333f alpha:1.0f];
        count.textAlignment= NSTextAlignmentCenter;
        count.layer.borderWidth = 0.5;
        count.layer.borderColor = [[UIColor colorWithRed:0.996f green:0.008f blue:0.333f alpha:1.0f]CGColor];

        count.text = [NSString stringWithFormat:@"%d", abs(ratio)];
        
        [self.contentView addSubview:count];
        
        
        followCountDown = [UIButton buttonWithType:UIButtonTypeCustom];
        followCountDown.frame = CGRectMake(120, 80, 24, 24);
        [followCountDown setBackgroundImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:followCountDown];


        follower = [[UILabel alloc]initWithFrame:CGRectMake(170, 80, 40, 24)];
        follower.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        follower.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:10];
        follower.textColor = [UIColor redColor];
        follower.text = @"Follower";
        follower.textAlignment= NSTextAlignmentCenter;
        
        [self.contentView addSubview:follower];
        
    }
    
    else
    {
        
        justFriends = [[UILabel alloc]initWithFrame:CGRectMake(165, 80, 65 , 24)];
        justFriends.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        justFriends.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:10];
        justFriends.textColor = [UIColor colorWithRed:0.498f green:0.498f blue:0.498f alpha:1.0f];
        justFriends.text = @"Just Friends";
        justFriends.textAlignment= NSTextAlignmentCenter;
        
        [self.contentView addSubview:justFriends];
        
        
        count = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 80, 24, 24)];
        count.layer.cornerRadius = 12;
        count.layer.masksToBounds= 1;
        count.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        count.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:11];
        count.textColor = [UIColor whiteColor];
        count.textAlignment= NSTextAlignmentCenter;
        count.layer.borderWidth = 0.5;
        count.layer.borderColor = [[UIColor grayColor]CGColor];
        count.text = [NSString stringWithFormat:@"%d", ratio];
        
        [self.contentView addSubview:count];
        
        
        followCountDown = [UIButton buttonWithType:UIButtonTypeCustom];
        followCountDown.frame = CGRectMake(120, 80, 24, 24);
        followCountDown.layer.cornerRadius = 12;
        followCountDown.layer.masksToBounds = YES;
        followCountDown.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:followCountDown];
  
    }
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
