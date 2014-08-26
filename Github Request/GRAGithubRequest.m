//
//  GRAGithubRequest.m
//  Github Request
//
//  Created by Eric Williams on 7/28/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "GRAGithubRequest.h"

@implementation GRAGithubRequest

+ (NSDictionary *) requestUserInfo: (NSString *) username
{
    // take the username and call the github url
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
 
    NSURL * url = [NSURL URLWithString: urlString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //mutable request
    
    NSMutableURLRequest * mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    [mutableRequest setHTTPMethod: @"POST"];
    
    //////////
    
    NSURLResponse * response = nil;
    
    NSError * error = nil;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    // if you see auto_releasing and two astericks with & add an & in method

    NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    NSLog(@"user info = %@", userInfo);

    return userInfo;
}

+ (void) saveUsers:(NSArray *)users
{
    // path to what we are saving
    NSString * path = [GRAGithubRequest usersArchivePath];
    
    // then we archive
    NSData * userData = [NSKeyedArchiver archivedDataWithRootObject:users];
    
    // then we save file
    [userData writeToFile:path options:NSDataWritingAtomic error:nil];
}

+ (NSArray *)loadUsers
{
    // path to what we are loading
    NSString * path = [GRAGithubRequest usersArchivePath];

    // then we unarchive
    NSArray * users = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    // then we return the array
    return users;
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
