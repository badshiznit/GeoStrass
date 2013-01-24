//
//  ListStationsVeloViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "DataCTS.h"
#import <UIKit/UIKit.h>
#import "MapStationsViewController.h"
#import "PullRefreshTableViewController.h"

@interface ListStationsVeloViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,
                                                            DataCTSDelegate,MapStationsViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *choixModeSegmentedcontrol;
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *showMapButtonItem;


- (IBAction)choixModeChange:(id)sender;
- (IBAction)refreshAction:(id)sender;
- (IBAction)showMapAction:(id)sender;

@end
