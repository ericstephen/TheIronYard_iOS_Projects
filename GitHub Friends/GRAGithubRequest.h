//
//  GRAGithubRequest.h
//  Github Request
//
//  Created by Eric Williams on 7/28/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAGithubRequest : NSObject

+ (NSDictionary *) requestUserInfo: (NSString *) username;

+ (void) saveUsers:(NSArray *)users;

+ (NSArray *)loadUsers;



@end
