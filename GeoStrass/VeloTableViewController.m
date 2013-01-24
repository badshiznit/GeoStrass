//
//  VeloViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 11/3/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "VeloTableViewController.h"

@interface VeloTableViewController ()

@end

@implementation VeloTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"velhop_man.png"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    NSLog(@"Colors changed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
