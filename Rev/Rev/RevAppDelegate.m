//
//  RevAppDelegate.m
//  Rev
//
//  Created by Eric Williams on 8/7/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "RevAppDelegate.h"


@implementation RevAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.rootViewController = [[UIViewController alloc]init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
