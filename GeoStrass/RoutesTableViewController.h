//
//  RoutesTableViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 2/19/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@interface RoutesTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UISearchBar *routeSearchBar;

+(Route*) getRouteFromId:(NSString*) routeId;

@end
