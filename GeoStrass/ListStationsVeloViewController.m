//
//  ListStationsVeloViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "ListStationsVeloViewController.h"

@interface ListStationsVeloViewController ()

@end

@implementation ListStationsVeloViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (IBAction)choixModeChange:(id)sender
{
    if(self.choixModeSegmentedcontrol.selectedSegmentIndex == 0)
    {
        self.title = @"Velo";
    }
    else
    {
        self.title = @"Pied";        
    }
}
@end
