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
    
    UIButton * urlSite;
    
    UIButton * gistSite;
    
    UILabel * followIn;
    
    UILabel * followOut;
    
    UITextField * searchBar;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        friendName = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 40)];
        friendName.font = [UIFont fontWithName:@"HelveticaNeue-Ultralight" size:30];
        
        [self.contentView addSubview:friendName];
        
        friendImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        friendImage.layer.cornerRadius = 20.0;
        friendImage.layer.masksToBounds = YES;
        
        [self.contentView addSubview:friendImage];
        
        friendLocation = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 40)];
        friendLocation.font = [UIFont fontWithName:@"HelveticaNeue-light" size:15];
        
        [self.contentView addSubview:friendLocation];
        
        urlSite = [[UIButton alloc] initWithFrame:CGRectMake(230, 60, 80, 20)];
        urlSite.backgroundColor = [UIColor grayColor];
        urlSite.layer.cornerRadius = 10;
        urlSite.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:13];
        [urlSite setTitle:@"PROFILE" forState:UIControlStateNormal];
        
        [self.contentView addSubview:urlSite];
        
        
        gistSite = [[UIButton alloc] initWithFrame:CGRectMake(230, 90, 80, 20)];
        gistSite.backgroundColor = [UIColor grayColor];
        gistSite.layer.cornerRadius = 10;
        gistSite.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:13];
        [gistSite setTitle:@"GIST" forState:UIControlStateNormal];
        
        [self.contentView addSubview:gistSite];
        
        followIn = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 120, 20)];
        followIn.font = [UIFont fontWithName:@"HelveticaNeue-light" size:13];
        followIn.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:followIn];
        
        followOut = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 120, 20)];
        followOut.font = [UIFont fontWithName:@"HelveticaNeue-light" size:13];
        followOut.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:followOut];
        

        
        
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
    
    
    NSString * followers = [NSString stringWithFormat:@"Followers : %@", friendInfo[@"followers"]];
    
    followIn.text = followers;
    
    NSString * following = [NSString stringWithFormat:@"Following : %@", friendInfo[@"following"]];
    
    followOut.text = following;
    
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
