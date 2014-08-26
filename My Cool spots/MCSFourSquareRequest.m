//
//  MCSFourSquareRequest.m
//  My Cool spots
//
//  Created by Eric Williams on 8/18/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MCSFourSquareRequest.h"

// https://api.foursquare.com/v2/venues/explore?oauth_token=PHS1OJEZHOY2CKHIIMYY0O3SLKTWP1ZDHI1OF4AMPYKZRSCX&v=20140818&ll=33.84888920,-84.373556&radius=1000

// create method that passes a lat, long and returns an array of venues

@implementation MCSFourSquareRequest

+ (NSDictionary *) requestLocationInfo: (NSString *) name
{
    // take the username and call the github url
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/explore?oauth_token=PHS1OJEZHOY2CKHIIMYY0O3SLKTWP1ZDHI1OF4AMPYKZRSCX&v=20140818&ll=33.84888920,-84.373556&radius=1000", name];
    
    NSURL * url = [NSURL URLWithString: urlString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //mutable request
    
    NSMutableURLRequest * mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    [mutableRequest setHTTPMethod: @"GET"];
    
    //////////
    
    NSURLResponse * response = nil;
    
    NSError * error = nil;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // if you see auto_releasing and two astericks with & add an & in method
    
    NSDictionary * locationInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    NSLog(@"user info = %@", locationInfo);
    
    return locationInfo;
}

+ (void) saveUsers:(NSArray *)users
{
    // path to what we are saving
    NSString * path = [MCSFourSquareRequest usersArchivePath];
    
    // then we archive
    NSData * userData = [NSKeyedArchiver archivedDataWithRootObject:users];
    
    // then we save file
    [userData writeToFile:path options:NSDataWritingAtomic error:nil];
}

+ (NSString *)usersArchivePath
{
    // returns array of directories
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    // grab first path from above array
    NSString * documentDirectory = documentDirectories[0];
    
    // return path/user.data
    return [documentDirectory stringByAppendingString:@"users.data"];
}



@end
