//
//  MSAData.m
//  Mayorships
//
//  Created by Eric Williams on 8/19/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MSAData.h"

@implementation MSAData

{
//    NSArray * vendorsWithMayors;
//    
//    NSArray * vendorsWithoutMayors;
}

+ (MSAData *)mainData;
{
    static dispatch_once_t create;
    
    static MSAData * singleton = nil;
    
    dispatch_once(&create, ^{
        
        singleton = [[MSAData alloc] init];
        
    });
    
    return singleton;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}
@end
