//
//  MSAData.h
//  Mayorships
//
//  Created by Eric Williams on 8/19/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAData : NSObject

@property (nonatomic) NSArray * vendorsWithMayors;
@property (nonatomic) NSArray * vendorsWithoutMayors;

+ (MSAData *)mainData;

@end
