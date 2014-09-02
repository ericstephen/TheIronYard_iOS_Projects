//
//  GFATableViewCell.m
//  GitHub Friends
//
//  Created by Eric Williams on 7/24/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "GFATableViewCell.h"
#import "GFAViewController.h"

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
        [gistSite addTarget:self action:@selector(gistSiteClicked) forControlEvents: UIControlEventTouchUpInside];
        
        [self.contentView addSubview:gistSite];
        
        
        gistCount = [[UILabel alloc] initWithFrame:CGRectMake(235, 80, 24, 24)];
        gistCount.backgroundColor = [UIColor whiteColor];
        gistCount.font = [UIFont fontWithName:@"HelveticaNeue-bold" size:12];
        gistCount.layer.cornerRadius = 12;
        gistCount.layer.masksToBounds = YES;
        gistCount.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:gistCount];
        
        
        profileButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 10, 24, 24)];
        UIImage *detailArrow = [UIImage imageNamed:@"profileArrow.png"];
        [profileButton setImage:detailArrow forState:UIControlStateNormal];
        [profileButton addTarget:self action:@selector(profileButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:profileButton];
        
        count = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 80, 24, 24)];
        count.layer.cornerRadius = 12;
        count.layer.masksToBounds= 1;
        count.textAlignment = NSTextAlignmentCenter;
        count.layer.borderWidth = 0.5;
        count.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        count.font = [UIFont fontWithName:@"HelveticaNeue-bold"size:10];
        
        //[self.contentView addSubview:count];

        leader = [[UILabel alloc]initWithFrame:CGRectMake(170, 80, 40, 24)];
        leader.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        leader.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:10];
        leader.textAlignment= NSTextAlignmentCenter;

        //[self.contentView addSubview:leader];
        
        
        follower = [[UILabel alloc]initWithFrame:CGRectMake(170, 80, 40, 24)];
        follower.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        follower.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:10];
        follower.textAlignment = NSTextAlignmentCenter;
        
        //[self.contentView addSubview:follower];
        
        
        justFriends = [[UILabel alloc]initWithFrame:CGRectMake(165, 80, 65 , 24)];
        justFriends.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.0f];
        justFriends.font = [UIFont fontWithName:@"HelveticaNeue-Light"size:10];
        justFriends.textAlignment = NSTextAlignmentCenter;
        
        //[self.contentView addSubview:justFriends];
        
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

        count.textColor = [UIColor colorWithRed:0.196f green:0.973f blue:0.749f alpha:1.0f];
        count.layer.borderColor = [[UIColor colorWithRed:0.098f green:0.976f blue:0.745f alpha:1.0f]CGColor];
        count.text = [NSString stringWithFormat:@"%d", abs (ratio)];
        
        [self.contentView addSubview:count];
        
        
        followCountUp = [UIButton buttonWithType:UIButtonTypeCustom];
        followCountUp.frame = CGRectMake(120, 80, 24, 24);
        [followCountUp setBackgroundImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:followCountUp];
        

        leader.textColor = [UIColor colorWithRed:0.196f green:0.973f blue:0.749f alpha:1.0f];
        leader.text = @"Leader";
        
        [self.contentView addSubview:leader];

    }
    
    else if  (ratio < 0)
    {

        count.textColor = [UIColor colorWithRed:0.996f green:0.008f blue:0.333f alpha:1.0f];
        count.layer.borderColor = [[UIColor colorWithRed:0.996f green:0.008f blue:0.333f alpha:1.0f]CGColor];
        count.text = [NSString stringWithFormat:@"%d", abs (ratio)];
        
        [self.contentView addSubview:count];
        
        
        followCountDown = [UIButton buttonWithType:UIButtonTypeCustom];
        followCountDown.frame = CGRectMake(120, 80, 24, 24);
        [followCountDown setBackgroundImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:followCountDown];

        
        follower.textColor = [UIColor redColor];
        follower.text = @"Follower";
        
        [self.contentView addSubview:follower];
        
    }
    
    else
    {
        
        justFriends.textColor = [UIColor colorWithRed:0.498f green:0.498f blue:0.498f alpha:1.0f];
        justFriends.text = @"Just Friends";
        
        [self.contentView addSubview:justFriends];
        
    
        count.textColor = [UIColor grayColor];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)profileButtonClicked
{
    GFAViewController * profileView = [[GFAViewController alloc] init];
    
    profileView.friendInfo = self.friendInfo;
    
    [self.navigationController pushViewController: profileView animated: YES];
    
    NSLog(@"profile button was clicked");
}

- (void)gistSiteClicked
{
    GFAViewController *profileView = [[GFAViewController alloc] init];
    
    NSString * gistURL = [NSString stringWithFormat:@"https://gist.github.com/%@", self.friendInfo[@"login"]];
    
    profileView.friendInfo = @{@"html_url":gistURL};
    
    [self.navigationController pushViewController:profileView animated:YES];
    
    NSLog(@"gist button was clicked");
}

@end
