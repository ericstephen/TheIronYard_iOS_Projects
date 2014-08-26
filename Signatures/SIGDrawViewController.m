//
//  SIGDrawViewController.m
//  Signatures
//
//  Created by Eric Williams on 8/13/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "SIGDrawViewController.h"

#import "SIGDrawView.h"

@interface SIGDrawViewController ()

@end

@implementation SIGDrawViewController
{
    UIView *lineDivider;
    UIView *sigLine;
    UIView *signatureBox;
    UIView *layer1;
    UIView *layer2;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
//        self.view = [[SIGDrawView alloc]initWithFrame:self.view.frame];
        
                
        lineDivider = [[UIView alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 5)];
        lineDivider.backgroundColor = [UIColor lightGrayColor];
        
        [self.view addSubview:lineDivider];
        
        signatureBox = [[UIView alloc]initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH - 30, 150)];
        signatureBox.layer.borderColor = [UIColor grayColor].CGColor;
        signatureBox.layer.borderWidth = 2;
        
        [self.view addSubview:signatureBox];
        
        
        layer1 = [[UIView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 100)];
        layer1.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:layer1];
        
        layer2 = [[UIView alloc]initWithFrame:CGRectMake(38, 30,SCREEN_WIDTH - 76 , 150)];
        layer2.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:layer2];
        
        
        sigLine = [[UIView alloc]initWithFrame:CGRectMake(40, 150, SCREEN_WIDTH - 80, 1)];
        sigLine.layer.borderColor = [UIColor grayColor].CGColor;
        sigLine.layer.borderWidth = 1;
        
        [self.view addSubview:sigLine];
        

        SIGDrawView * drawView = [[SIGDrawView alloc] initWithFrame:self.view.frame];
        
        [self.view addSubview:drawView];
        
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
