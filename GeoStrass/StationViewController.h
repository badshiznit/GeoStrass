//
//  StationViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 1/8/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationVelhop.h"
#import "LocalisationMgr.h"

@interface StationViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) StationVelhop* station;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
