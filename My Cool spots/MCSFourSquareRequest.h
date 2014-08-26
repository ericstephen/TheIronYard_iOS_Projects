//
//  MCSFourSquareRequest.h
//  My Cool spots
//
//  Created by Eric Williams on 8/18/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSFourSquareRequest : NSObject

+ (NSDictionary *) requestLocationInfo: (NSString *) name;

+ (void) saveUsers:(NSArray *)users;

+ (NSString *)usersArchivePath;



@end
