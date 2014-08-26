//
//  STANewEditItemViewController.m
//  Simple Tasks
//
//  Created by Eric Williams on 7/30/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "STANewEditItemViewController.h"

#import "STAEditItemViewController.h"

@interface STANewEditItemViewController ()

@end

@implementation STANewEditItemViewController

UITextField * itemNameField;

UIButton * itemSave;

UIButton * itemClose;

UISlider * sliderColor;

float priority;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
            }
    
    self.view.backgroundColor = [UIColor colorWithRed:0.965f green:0.376f blue:0.145f alpha:1.0f];
    
    return self;
}

-(void)dismissKeyboard
    {
        [itemNameField resignFirstResponder];
    }
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];

    itemNameField = [[UITextField alloc] initWithFrame: CGRectMake(20, 25, SCREEN_WIDTH - 40, 40)];
    itemNameField.backgroundColor = [UIColor clearColor];
    itemNameField.placeholder = @"item name";
    UIColor *color = [UIColor whiteColor];
    itemNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"item name" attributes:@{NSForegroundColorAttributeName: color}];
    itemNameField.font = [UIFont fontWithName: @"HelveticaNeue-light" size:30];
    
    [self.view addSubview:itemNameField];
    
    
    UITextField * borderLine =[[UITextField alloc] initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH - 40, 1)];
    borderLine.layer.borderColor = [UIColor whiteColor].CGColor;
    borderLine.layer.borderWidth = 1;
    
    [self.view addSubview:borderLine];
    
    
    UIButton * itemSave = [[UIButton alloc] initWithFrame:CGRectMake(178, 400, 110, 110)];
    itemSave.layer.cornerRadius = 40;
    [itemSave addTarget:self action:@selector(itemSaveClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *itemSearch = [UIImage imageNamed:@"item_save.png"];
    itemSave.adjustsImageWhenHighlighted = NO;
    [itemSave setImage:itemSearch forState:UIControlStateNormal];
    
    [self.view addSubview:itemSave];
    
    
    UIButton * itemClose = [[UIButton alloc] initWithFrame:CGRectMake(32, 400, 110, 110)];
    itemClose.layer.cornerRadius = 40;
    [itemClose addTarget:self action:@selector(itemCloseClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage * itemClosed = [UIImage imageNamed:@"item_close"];
    itemClose.adjustsImageWhenHighlighted = NO;
    [itemClose setImage:itemClosed forState:UIControlStateNormal];
    
    [self.view addSubview:itemClose];
    
    
    UISlider * sliderColor = [[UISlider alloc]initWithFrame:CGRectMake(100, 204, 400, 100)];
    
    sliderColor.backgroundColor = [UIColor clearColor];
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * 0.5);
    sliderColor.transform = trans;
    
    [self.view addSubview:sliderColor];
    
    // Do any additional setup after loading the view.
}

-(void)itemSaveClicked
{
    [self.items addObject:[@{
                              @"name": itemNameField.text,
                              @"priority": [NSNumber numberWithFloat:priority]
                              } mutableCopy]];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)itemCloseClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    UITouch * touch = [touches allObjects][0];
    
    //    CGPoint location = [touch locationInView:self.view];
    
    [self changeColorWithLocation:[[touches allObjects][0] locationInView:self.view]];  //  condensing code above
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    UITouch * touch = [touches allObjects][0];
    
    //    CGPoint location = [touch locationInView:self.view];
    
    [self changeColorWithLocation:[[touches allObjects][0] locationInView:self.view]];  //  condensing code above
    
}

- (void)changeColorWithLocation:(CGPoint)location
{
     priority = location.y / SCREEN_HEIGHT * 60;
    
    self.itemInfo[@"priority"] = @(priority);
    
    float priorityHue = priority / 360;
    
    self.view.backgroundColor = [UIColor colorWithHue:priorityHue saturation:1.0 brightness:1.0 alpha:1.0];



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
}

@end
