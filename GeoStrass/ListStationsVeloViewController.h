//
//  ListStationsVeloViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "DataCTS.h"
#import <UIKit/UIKit.h>

@interface ListStationsVeloViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DataCTSDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *choixModeSegmentedcontrol;


- (IBAction)choixModeChange:(id)sender;
- (IBAction)refreshAction:(id)sender;

@end
