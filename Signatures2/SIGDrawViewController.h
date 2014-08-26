//
//  SIGDrawViewController.h
//  Signatures2
//
//  Created by Eric Williams on 8/14/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIGDrawView;

@interface SIGDrawViewController : UIViewController

@property (nonatomic) SIGDrawView * drawView;

- (void)clearSignature;

- (UIImage *)getSignature;

@end
