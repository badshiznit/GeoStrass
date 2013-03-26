//
//  ListStationsVeloViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "ListStationsVeloViewController.h"
#import "StationViewController.h"
#import "StationVeloCell.h"
#import "LocalisationMgr.h"


@interface ListStationsVeloViewController ()

@property(nonatomic,strong) DataCTS* dataCTS;
@property(nonatomic,strong) NSArray* sortedStations;
@property(nonatomic,strong) NSArray* stations;
@property(nonatomic,strong) CLLocation* userLocation;
@property(nonatomic,strong) LocalisationMgr* localisationMgr;

@property(nonatomic,assign) BOOL userOnBike;
@property(nonatomic,assign) BOOL mapShown;
@property(nonatomic,strong) MapStationsViewController* mapStationsViewController;

@property(nonatomic,strong) NSTimer* timerForRefresh;
@property(nonatomic,strong) UIRefreshControl* refreshControl;
@property(nonatomic,strong) UIBarButtonItem* leftBarButtonItem;

@end

@implementation ListStationsVeloViewController

#pragma mark - mark Initialization

-(void) initInterface
{
    UIButton* button = self.showMapButtonItem;
    [[button layer] setCornerRadius:5.0f];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setBorderWidth:0.0f];

    [self.showMapButtonItem setImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initInterface];
	// Do any additional setup after loading the view.
     self.dataCTS = [[DataCTS alloc] initWithUrl:@"http://velhop.strasbourg.eu/tvcstations.xml"];
    self.dataCTS.delegate = self;
    [self.dataCTS loadData];

    self.timerForRefresh = [NSTimer scheduledTimerWithTimeInterval:2000.0
                                                            target:self
                                                          selector:@selector(refreshData)
                                                          userInfo:nil
                                                           repeats:YES];
    // adding Refresh Control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];
    self.refreshControl.tintColor = VELHOP_COLOR_WITH_ALPHA(1.0);

/*    NSString* titre = @"Mise à jour...";
    NSMutableAttributedString *a = [[NSMutableAttributedString alloc] initWithString:titre];
    [a addAttribute:NSForegroundColorAttributeName value:VELHOP_COLOR_WITH_ALPHA(1.0) range:NSMakeRange(0, [titre length])];
    self.refreshControl.attributedTitle = a;*/
    
    // Changing TableView BackGround
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"velhopBck.png"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    self.leftBarButtonItem = self.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = nil;
    
    //Changing Navigation bar color
   // self.navigationController.navigationBar.tintColor = VELHOP_COLOR_WITH_ALPHA(0.5);
    
    //localisation
    self.localisationMgr = [LocalisationMgr mgr];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUserLocationUpdated:)
                                                 name:@"onUserLocationUpdated" object:nil];
    [self.localisationMgr getUserLocation];
}                            
                        
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 70.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sortedStations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    StationVeloCell* stationCell = (StationVeloCell*) cell;
    
    if(stationCell)
    {
        StationVelhop* station = [self.sortedStations objectAtIndex:indexPath.row];
        stationCell.userOnBike = self.userOnBike;
        [stationCell fillCellWithstation:station];
        [stationCell computeDistanceFromLocation:self.userLocation];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    StationViewController* stationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsStationViewController"];
    stationVC.station = [self.sortedStations objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:stationVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

- (IBAction)choixModeChange:(id)sender
{
    self.choixModeSegmentedcontrol = (UISegmentedControl*) sender;
    if(self.choixModeSegmentedcontrol.selectedSegmentIndex == 0)
    {
        self.userOnBike = YES;
    }
    else
    {
        self.userOnBike = NO;
    }
    if(self.mapStationsViewController)
        [self.mapStationsViewController changeMode:self.userOnBike];
    
    [self.tableView reloadData];
}

- (IBAction)refreshAction:(id)sender
{
    NSLog(@"Timer : %@",self.timerForRefresh.description);
    if(self.timerForRefresh.timeInterval > 10)
    {
       // [self.timerForRefresh invalidate];
        [self.dataCTS loadData];
    }
}

-(void) refreshData
{
    self.userLocation = nil;
    [self.localisationMgr getUserLocation];
    [self.dataCTS loadData];
}

- (IBAction)showMapAction:(id)sender
{
    if(!self.mapStationsViewController)
    {
        self.mapStationsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
        self.mapStationsViewController.userOnBike = self.userOnBike;
        self.mapStationsViewController.stations = self.sortedStations;
        self.mapStationsViewController.delegate = self;
    }
    
  
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    UIViewAnimationTransition transition = (self.mapShown)? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft;
    [UIView setAnimationTransition:transition
                           forView:self.view
                             cache:NO];
    [UIView commitAnimations];
    
    [self modeChangeWithState:self.mapShown];
    
    if(!self.mapShown)
    {
        //[self.myView removeFromSuperview];
        [self.view addSubview:self.mapStationsViewController.view];
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
    }
    else
    {
        [self.mapStationsViewController.view removeFromSuperview];
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    self.mapShown = !self.mapShown;
}

-(void) modeChangeWithState:(BOOL) selected
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    UIViewAnimationTransition transition = (selected)? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft;
    [UIView setAnimationTransition:transition
                           forView:self.showMapButtonItem.viewForBaselineLayout
                             cache:NO];
    [UIView commitAnimations];
    
   if(!selected)
   {
       [self.showMapButtonItem setImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
   }
    else
    {
        [self.showMapButtonItem setImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];
    }
}

#pragma mark Data CTS Delegate

-(void) didFinishedLoadingData:(NSArray *)stations
{
    self.stations = stations;
    [self sortStationsByDistance];
}

-(void) sortStationsByDistance
{
    for (StationVelhop* station in self.stations)
    {
        CLLocation* stationLoc = [[CLLocation alloc] initWithLatitude:station.coordinate.latitude
                                                            longitude:station.coordinate.longitude];
        station.distanceFromUser = [stationLoc distanceFromLocation:self.userLocation];
    }
    self.sortedStations = [StationVelhop sortArrayOfStations:self.stations];
    
    [self.tableView reloadData];
    if(self.userLocation)
    {
        if(self.refreshControl.isRefreshing)
            [self.refreshControl endRefreshing];
    }
}


#pragma mark Map Delegate

-(void) didSelectedStation:(StationVelhop *)station
{
    StationViewController* stationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsStationViewController"];
    stationVC.station = station;
    [self.navigationController pushViewController:stationVC animated:YES];
}

#pragma mark User Locaion Management

-(void) onUserLocationUpdated:(NSNotification*) notification
{
    if(notification.object)
    {
        NSLog(@"onUserLocationUpdated with location : %@",notification.description);
        self.userLocation = (CLLocation*)notification.object;
        [self sortStationsByDistance];
    }
}

@end
