//
//  StationViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 1/8/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationVelhop.h"

@interface StationViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) StationVelhop* station;

@end
