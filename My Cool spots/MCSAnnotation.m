//
//  MCSAnnotation.m
//  My Cool spots
//
//  Created by Eric Williams on 8/18/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MCSAnnotation.h"

@implementation MCSAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
}

@end
