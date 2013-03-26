//
//  AroundMeTableViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tram+BusStations.h"
#import "RoutesTableViewController.h"
#import "SuperStation.h"

@interface AroundMeTableViewController : UITableViewController<Tram_BusStationsDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *stopSearchBar;
@property(nonatomic,strong) RoutesTableViewController* routesTableViewController;

- (IBAction)refreshAction:(id)sender;
- (IBAction)searchAction:(id)sender;

@end
