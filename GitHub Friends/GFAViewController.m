//
//  GFAViewController.m
//  GitHub Friends
//
//  Created by Eric Williams on 7/25/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "GFAViewController.h"

@interface GFAViewController ()

@end

@implementation GFAViewController
{
    UIWebView * webView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        webView = [[UIWebView alloc] initWithFrame: self.view.frame];
        
        [self.view addSubview:webView];
    }
    return self;
}
- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setFriendInfo:(NSDictionary *)friendInfo
{
    _friendInfo = friendInfo;
    
    NSURL * url = [NSURL URLWithString: friendInfo[@"html_url"]];
    
    NSURLRequest * request = [NSURLRequest requestWithURL: url];
    [webView loadRequest: request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
