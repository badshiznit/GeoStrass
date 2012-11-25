//
//  ListStationsVeloViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListStationsVeloViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *choixModeSegmentedcontrol;

- (IBAction)choixModeChange:(id)sender;

@end
