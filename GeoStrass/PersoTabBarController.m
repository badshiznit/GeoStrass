//
//  PersoTabBarController.m
//  GeoStrass
//
//  Created by amadou diallo on 1/24/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "PersoTabBarController.h"
#import "AroundMeTableViewController.h"
#import "RoutesTableViewController.h"
#import <QuartzCore/QuartzCore.h>

#define SIZE 60

@interface PersoTabBarController ()

@property(nonatomic,strong) AroundMeTableViewController* aroundMeTableViewController;
@property(nonatomic,strong) RoutesTableViewController* routesTableViewController;

@end

@implementation PersoTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addCenterButtonWithImage:[UIImage imageNamed:@"aroundMe.png"] highlightImage:[UIImage imageNamed:@"aroundMeSelected.png"]];
    
    [self setSelectedIndex:3];
    
    UINavigationController* navc = [[self viewControllers] objectAtIndex:3];
    self.routesTableViewController = [[navc viewControllers] objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, SIZE, SIZE);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = SIZE - self.tabBar.frame.size.height + 10;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.view addSubview:button];
    
    self.aroundMeButton = button;
    
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    
    [self.aroundMeButton addTarget:self action:@selector(showAroundMe:) forControlEvents:UIControlEventTouchUpInside];
}



-(void) showAroundMe:(id) sender
{
    NSLog(@"Show Around Me");
  
   [self performSegueWithIdentifier:@"pushAroundMeModalVC" sender:self];

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushAroundMeModalVC"])
    {
        if(!self.aroundMeTableViewController)
        {
            UINavigationController* nvc = (UINavigationController*) segue.destinationViewController;
            
            self.aroundMeTableViewController = (AroundMeTableViewController*)[[nvc viewControllers] objectAtIndex:0];
            self.aroundMeTableViewController.routesTableViewController = self.routesTableViewController;
        }
        else
        {
            UINavigationController* nvc = (UINavigationController*) segue.destinationViewController;
            [nvc setViewControllers:[NSArray arrayWithObject:self.aroundMeTableViewController]];
        }
    }
}


@end
