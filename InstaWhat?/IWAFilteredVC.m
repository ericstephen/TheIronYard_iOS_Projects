//
//  IWAFilteredVC.m
//  InstaWhat?
//
//  Created by Eric Williams on 8/25/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "IWAFilteredVC.h"

#import "IWAFilterVC.h"


@interface IWAFilteredVC ()

@end

@implementation IWAFilteredVC
{
    UIViewController * filteredVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    filteredVC = [[IWAFilteredVC alloc]init];
    filteredVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 320);
    
    [self.view addSubview:filteredVC.view];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
