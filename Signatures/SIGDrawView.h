//
//  SIGDrawView.h
//  Signatures
//
//  Created by Eric Williams on 8/13/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIGDrawView : UIView

@property (nonatomic) NSMutableArray * signatures;

@property (nonatomic) int signatureWidth;

@property (nonatomic) NSMutableDictionary * currentSignature;

@property (nonatomic) UIColor * lineColor;

@property (nonatomic) BOOL drawStyle;


@end
