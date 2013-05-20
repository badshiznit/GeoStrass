//
//  AroundMeTableViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "AroundMeTableViewController.h"
#import "LocalisationMgr.h"
#import "AutoScrollLabel.h"
#import "NextPassagesViewController.h"

#define STOP_NAME_TAG     111
#define STOP_IMAGE_TAG    112
#define STOP_CITY_TAG     113
#define STOP_DISTANCE_TAG 114
#define STOP_ROUTES_VIEW_TAG 115

@interface AroundMeTableViewController ()

@property(nonatomic,strong) Tram_BusStations* tbs;
@property(nonatomic,strong) NSArray* stations;
@property(nonatomic,strong) NSArray* sortedSuperStations;

@property(nonatomic,strong) NSMutableArray* filteredStations;

@property(nonatomic,strong) NSMutableArray* buss;
@property(nonatomic,strong) NSMutableArray* tramss;
@property(nonatomic,strong) NSMutableArray* navettes;

@property(nonatomic,strong) CLLocation* userLocation;
@property(nonatomic,strong) CLPlacemark* placemark;
@property(nonatomic,strong) NSString* lastUpdate;

@property(nonatomic,strong) UISegmentedControl* choixTypeTransportScope;

@property BOOL isSorted;

@end

@implementation AroundMeTableViewController

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  //  [self.refreshControl beginRefreshing];
    // [[LocalisationMgr mgr] getUserLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tbs = [Tram_BusStations stations];
    
    self.stations= [self.tbs.stations allValues];
    
    self.tbs.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUserLocationUpdated:)
                                                 name:@"onUserLocationUpdated" object:nil];
    
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    
    self.filteredStations = [[NSMutableArray alloc] init];
    self.buss = [[NSMutableArray alloc] init];
    self.tramss = [[NSMutableArray alloc] init];
    self.navettes = [[NSMutableArray alloc] init];
}

-(void)didFinishComputeStations:(Tram_BusStations *)tramBusStations
{
    NSLog(@"Receivve Notiff");
    self.stations = [tramBusStations.joinedStations allValues];
    
    
    
    [self refreshView:self.refreshControl];
}

-(void)separeBusTramsNAvettes
{
    for (SuperStation* superStation in self.stations)
    {
        //
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(!self.lastUpdate)
        return nil;
    
    UITableViewCell* headerCell = [self.tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    
    AutoScrollLabel *autoScrollLabel= (AutoScrollLabel*)[headerCell viewWithTag:111];
    autoScrollLabel.textColor=[UIColor whiteColor];
    [autoScrollLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    autoScrollLabel.text= [NSString stringWithFormat:@" Localisé à : %@",self.lastUpdate];
    autoScrollLabel.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.5];
    autoScrollLabel.labelSpacing = 30; // distance between start and end labels
    autoScrollLabel.pauseInterval = 0; // seconds of pause before scrolling starts again
    autoScrollLabel.scrollSpeed = 50; // pixels per second
    
    self.choixTypeTransportScope = (UISegmentedControl*) [headerCell viewWithTag:112];
    [self.choixTypeTransportScope addTarget:self action:@selector(didModeChanged:) forControlEvents:UIControlEventValueChanged];
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, _choixTypeTransportScope.frame.size.height + autoScrollLabel.frame.size.height)];
    
    [header addSubview:self.choixTypeTransportScope];
    [header addSubview:autoScrollLabel];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return autoScrollLabel;
    }
    else
    {
      return header;  
    } 
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return 25.f;
    }
    else
    {
        if(self.lastUpdate)
            return 45.f;
        else
            return 0.f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredStations count];
    }
    
    if(self.sortedSuperStations)
    {
        return (self.sortedSuperStations.count);
    }
    
    NSLog(@"numberOfRowsInSection : %d",self.stations.count);
    return self.stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stopCell";

    UITableViewCell* cell;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
	else
	{
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        AroundMeMasterCell* masterCell = (AroundMeMasterCell*)cell;
        if(masterCell)
        {
            masterCell.delegate = self;
            SuperStation* masterStation = [self.filteredStations objectAtIndex:indexPath.row];
            [masterCell setMasterStation:masterStation withScope:self.searchDisplayController.searchBar.selectedScopeButtonIndex];
        }
    }
	else
	{
       //[self fillCell:cell firIndexPath:indexPath];
        AroundMeMasterCell* masterCell = (AroundMeMasterCell*)cell;
         masterCell.delegate = self;
        if(masterCell)
        {
             SuperStation* masterStation = [self.sortedSuperStations objectAtIndex:indexPath.row];
            [masterCell setMasterStation:masterStation withScope:self.choixTypeTransportScope.selectedSegmentIndex];
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NextPassagesViewController* stationInfosViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StationInfosViewController"];
    
    SuperStation* masterStation;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        masterStation = [self.filteredStations objectAtIndex:indexPath.row];
    }
	else
	{
        masterStation = [self.sortedSuperStations objectAtIndex:indexPath.row];
    }
    
    stationInfosViewController.station = masterStation;
    [self.navigationController pushViewController:stationInfosViewController animated:YES];
}

- (IBAction)refreshAction:(id)sender
{
    NSLog(@"Refreshhhhh...");
    
   // 
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Refreshing Data

-(void) performGeocodeFromLocation:(CLLocation*) location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //  NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        NSLog(@"Received placemarks %@\n",placemarks);
        if(placemarks.count > 0)
        {
            self.placemark = [placemarks objectAtIndex:0];
            
            NSString* address = [NSString stringWithFormat:@"%@, %@, %@",_placemark.subThoroughfare, [_placemark thoroughfare],_placemark.locality];
            
            address = [address stringByReplacingOccurrencesOfString:@"(null), " withString:@""];
            
            NSString* precision = [NSString stringWithFormat:@"Précision : %d m",(int)self.userLocation.horizontalAccuracy];
            
            self.lastUpdate = [NSString stringWithFormat:@"%@ (%@)",address,
                                     precision];
            [self.tableView reloadData];
        }
    }];
}

-(void)refreshView:(UIRefreshControl *)refresh
{
    [[LocalisationMgr mgr] getUserLocation];
    NSString* message = [NSString stringWithFormat:@"Localisation en cours..."];
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:message];
    NSInteger _stringLength=[message length];
    UIFont *font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15.0f];
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, _stringLength)];
    
    refresh.attributedTitle = attString;
    
    if(!refresh.isRefreshing)
    {
        [self.refreshControl beginRefreshing];
        CGRect refreshFrame = CGRectMake(self.refreshControl.frame.origin.x,
                                         self.refreshControl.frame.origin.y/10,
                                         self.refreshControl.frame.size.width,
                                         self.refreshControl.frame.size.height);
        [self.tableView scrollRectToVisible:refreshFrame animated:YES];
    }
}

-(void) stopRefresh
{
    [self.refreshControl endRefreshing];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Dernière mise à jour : %@",
                             [formatter stringFromDate:[NSDate date]]];
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:lastUpdated];
    NSInteger _stringLength=[lastUpdated length];
    UIColor *_black=[UIColor darkGrayColor];
    UIFont *font=[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSForegroundColorAttributeName value:_black range:NSMakeRange(0, _stringLength)];
    
    self.refreshControl.attributedTitle = attString;
}


- (IBAction)searchAction:(id)sender
{
 //   self.stopSearchBar.hidden = NO;
    [self.stopSearchBar becomeFirstResponder];
}


#pragma mark User Locaion Management

-(void) onUserLocationUpdated:(NSNotification*) notification
{
    if(notification.object)
    {
        NSLog(@"onUserLocationUpdated with location : %@",notification.description);
        self.userLocation = (CLLocation*)notification.object;
        [self performGeocodeFromLocation:self.userLocation];
        [self _executeToTheBackground];
    }
}

-(void) sortStationsByDistance
{
    NSMutableArray* listSuperStations = [[NSMutableArray alloc] init];
    
    for (NSMutableArray* stations in self.stations)
    {
        SuperStation* superStation = [[SuperStation alloc] initWithStations:stations];
        [listSuperStations addObject:superStation];
    }
    
    self.sortedSuperStations = [Station sortArrayOfStations:listSuperStations fromLocation:self.userLocation];
}

-(void)_executeToTheBackground
{
    NSLog(@"begin compute Locations from : %@",self.userLocation);
    NSOperationQueue *_computeQueue = [[NSOperationQueue alloc] init];
    
    [_computeQueue addOperationWithBlock:
     ^(void)
     {
         [self sortStationsByDistance];
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:^(void)
          {
              self.isSorted = YES;
              [self stopRefresh];
              [self.tableView reloadData];
          }];
     }];
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredStations removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@",searchText];
    NSArray *tempArray = [self.sortedSuperStations filteredArrayUsingPredicate:predicate];
    
    if(![scope isEqualToString:@"Tous"])
    {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
        
        if([scope isEqualToString:@"Trams"])
        {
            for (SuperStation* sStation in tempArray)
            {
                [sStation.busRoutes removeAllObjects];
            }
        }
        
        if([scope isEqualToString:@"Bus"])
        {
            for (SuperStation* sStation in tempArray)
            {
                [sStation.tramRoutes removeAllObjects];
            }
        }
    }
    
    self.filteredStations = [NSMutableArray arrayWithArray:tempArray];
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Segmented Control Change

-(void)didModeChanged:(UISegmentedControl*)sender
{
   // [self.tableView reloadData];
}

#pragma mark - AroundMeMasterCell Delegate Method

-(void) didSelectRouteAtCell:(AroundMeMasterCell *)aroundMeMasterCell
{
    NSLog(@"didSelectRouteAtCell %@",aroundMeMasterCell.selectedRoute.routeShortName);

    NextPassagesViewController* stationInfosViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StationInfosViewController"];
    stationInfosViewController.station = aroundMeMasterCell.masterStation;
    stationInfosViewController.selectedRouteShortName = aroundMeMasterCell.selectedRoute.routeShortName;
    [self.navigationController pushViewController:stationInfosViewController animated:YES];
}

@end
