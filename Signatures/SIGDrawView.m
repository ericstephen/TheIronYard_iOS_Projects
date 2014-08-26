//
//  SIGDrawView.m
//  Signatures
//
//  Created by Eric Williams on 8/13/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "SIGDrawView.h"

@implementation SIGDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.signatures = [@[] mutableCopy];
        self.signatureWidth = 3;
        self.backgroundColor = [UIColor clearColor];
        self.tintColor = [UIColor darkGrayColor];
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // this sets stroke or fill colors that follow
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    for (NSDictionary * signature in self.signatures)
    {
        CGContextSetLineWidth(context, [signature[@"width"] intValue]);
        
        NSArray * points = signature[@"points"];

        
        if (points.count > 0)
        {
            CGPoint startPoint = [points[0] CGPointValue];
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        };
        
        for (NSValue * pointVal in points)
        {
            CGPoint point = [pointVal CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        
        // this draws the text
        CGContextStrokePath(context);
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentSignature = [@{
                              @"points": [@[] mutableCopy],
                              @"width": @(self.signatureWidth)
                              } mutableCopy];
    
    [self.signatures addObject:self.currentSignature];
    
    if (self.drawStyle)
    {
        [self signatureWithTouches:touches];
        
    } else {
        
        UITouch * touch = [touches allObjects][0];
        CGPoint location = [touch locationInView:self];
        self.currentSignature[@"points"][0] = [NSValue valueWithCGPoint:location];
        
        [self setNeedsDisplay];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
        [self signatureWithTouches:touches];
        [self setNeedsDisplay];
    }


- (void)signatureWithTouches: (NSSet *)touches
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        [self.currentSignature[@"points"] addObject:[NSValue valueWithCGPoint:location]];
    }
    
    [self setNeedsDisplay];
}




@end
