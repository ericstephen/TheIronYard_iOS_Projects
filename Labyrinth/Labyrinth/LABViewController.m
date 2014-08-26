//
//  LABViewController.m
//  Labyrinth
//
//  Created by Eric Williams on 8/14/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "LABViewController.h"

#import <CoreMotion/CoreMotion.h>

#import "LABGraphView.h"

@interface LABViewController () <UICollisionBehaviorDelegate>

@end

@implementation LABViewController
{
    CMMotionManager * motionManager;
    
    UIDynamicAnimator * animator;
    
    UIGravityBehavior * gravityBehavior;
    
    UICollisionBehavior * collisionBehavior;
    
    UIDynamicItemBehavior * wallBehavior;
    
    UIView * ball;
    UIView * wall;
    UIView * wall2;
    UIView * wall3;
    UIView * wall4;
    UIView * wall5;
    UIView * wall6;
    UIView * wall7;
    UIView * wall8;
    UIView * wall9;
    UIView * finishPoint;
    
    float xRotation;
    float yRotation;
    
    UIButton * startButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor redColor];
        
        animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);

        gravityBehavior = [[UIGravityBehavior alloc]init];
        [animator addBehavior:gravityBehavior];
        
        collisionBehavior = [[UICollisionBehavior alloc] init];
        collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        [animator addBehavior:collisionBehavior];
        
        collisionBehavior.collisionDelegate = self;
        [collisionBehavior addBoundaryWithIdentifier:@"finish" fromPoint:CGPointMake(550, 5) toPoint:CGPointMake(550, 25)];
        
        wallBehavior = [[UIDynamicItemBehavior alloc] init];
        wallBehavior.density = 100000000;
        [animator addBehavior:wallBehavior];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    startButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2.0, (SCREEN_HEIGHT - 100) /2.0, 100, 100)];
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor blueColor];
    startButton.layer.cornerRadius = 50;
    
    [self.view addSubview:startButton];

    //    Do any additional setup after loading the view.
    
    //        LABGraphView * graphView = [[LABGraphView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    //
    //        [self.view addSubview:graphView];
    
    
    motionManager = [[CMMotionManager alloc] init];
    
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * motion, NSError * error) {
        
        NSLog(@"x %f y %f z %f", motion.rotationRate.x, motion.rotationRate.y, motion.rotationRate.z);
        
        xRotation -= motion.rotationRate.x / 30;
        yRotation += motion.rotationRate.y / 30;
        
        [self updateGravity];
        
        //                if (graphView.xPlots.count > self.view.frame.size.height / 10.0)
        //                {
        //                    [graphView.xPlots removeObjectAtIndex:0];
        //                }
        //
        //                [graphView.xPlots addObject:@(motion.rotationRate.x * 50)];
        //                [graphView setNeedsDisplay];
        
    }];
    
}
- (void)updateGravity
{
    gravityBehavior.gravityDirection = CGVectorMake(xRotation, yRotation);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    xRotation = yRotation = 0;
    [self updateGravity];
}

-(void)startGame
{
    CGFloat hue = (arc4random() % 256 / 256.0 );
    CGFloat saturation = (arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0 ) + 0.5;
    UIColor * color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    self.view.backgroundColor = color;
    
    ball = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
    ball.backgroundColor = [UIColor redColor];
    ball.layer.cornerRadius = 15;
    
    [self.view addSubview:ball];
    
    [gravityBehavior addItem:ball];
    [collisionBehavior addItem:ball];
    
    wall = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 60, 200)];
    wall.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    wall.layer.cornerRadius = 10;
    [self.view addSubview: wall];
    
    [collisionBehavior addItem: wall];
    [wallBehavior addItem: wall];
    
    
    wall2 = [[UIView alloc]initWithFrame:CGRectMake(300, 0, 60, 140)];
    wall2.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    wall2.layer.cornerRadius = 10;
    [self.view addSubview: wall2];
    
    [collisionBehavior addItem:wall2];
    [wallBehavior addItem:wall2];
    
    
    wall3 = [[UIView alloc]initWithFrame:CGRectMake(300, 140, 160, 60)];
    wall3.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    wall3.layer.cornerRadius = 10;
    [self.view addSubview: wall3];
    
    [collisionBehavior addItem:wall3];
    [wallBehavior addItem:wall3];
    
    
    wall4 = [[UIView alloc]initWithFrame:CGRectMake(175, 240, 60, 80)];
    wall4.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    wall4.layer.cornerRadius = 10;
    [self.view addSubview: wall4];
    
    [collisionBehavior addItem:wall4];
    [wallBehavior addItem:wall4];
    
    
    wall5 = [[UIView alloc]initWithFrame:CGRectMake(175, 60, 60, 150)];
    wall5.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    wall5.layer.cornerRadius = 10;
    [self.view addSubview: wall5];
    
    [collisionBehavior addItem:wall5];
    [wallBehavior addItem:wall5];
    
    
    wall6 = [[UIView alloc]initWithFrame:CGRectMake(443, 50, 125, 40)];
    wall6.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    wall6.layer.cornerRadius = 10;
    [self.view addSubview: wall6];
    
    [collisionBehavior addItem:wall6];
    [wallBehavior addItem:wall6];
    
    
    wall7 = [[UIView alloc]initWithFrame:CGRectMake(300, 0, 60, 140)];
    wall7.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    [self.view addSubview: wall7];
    
    
    wall8 = [[UIView alloc]initWithFrame:CGRectMake(300, 140, 140, 40)];
    wall8.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    [self.view addSubview: wall8];
    
    wall9 = [[UIView alloc]initWithFrame:CGRectMake(375, 245, 150, 40)];
    wall9.layer.cornerRadius = 10;
    wall9.backgroundColor = [UIColor colorWithRed:0.722f green:0.655f blue:0.510f alpha:1.0f];
    [self.view addSubview:wall9];
    
    
    finishPoint = [[UIView alloc]initWithFrame:CGRectMake(510, 5, 40, 40)];
    finishPoint.backgroundColor = [UIColor greenColor];
    finishPoint.layer.cornerRadius = 20;
    [self.view addSubview:finishPoint];

    [self.view addSubview:startButton];

    [startButton removeFromSuperview];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([@"finish" isEqualToString:(NSString*)identifier])
    {
        UIView * finishItem = (UIView *)item;
        
        [collisionBehavior removeItem:finishItem];
        [finishItem removeFromSuperview];
    }
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

-(BOOL)prefersStatusBarHidden {return YES;}

@end
