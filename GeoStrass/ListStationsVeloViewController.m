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


@interface ListStationsVeloViewController ()

@property(nonatomic,strong) DataCTS* dataCTS;
@property(nonatomic,strong) NSArray* stations;
@property(nonatomic,strong) CLLocation* userLocation;

@property(nonatomic,assign) BOOL userOnBike;
@property(nonatomic,assign) BOOL mapShown;
@property(nonatomic,strong) MapStationsViewController* mapStationsViewController;

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
     self.dataCTS = [[DataCTS alloc] initWithUrl:@"http://velhop.strasbourg.eu/tvcstations.xml"];
    self.dataCTS.delegate = self;
    [self.dataCTS loadData];
    self.title = @"Stations";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    StationVeloCell* stationCell = (StationVeloCell*) cell;
    
    if(stationCell)
    {
        StationVelhop* station = [self.stations objectAtIndex:indexPath.row];
        stationCell.userOnBike = self.userOnBike;
        [stationCell fillCellWithstation:station];
        CLLocation* userlocation = [[CLLocation alloc] initWithLatitude:48.602573 longitude:7.776165];
        [stationCell computeDistanceFromLocation:userlocation];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    StationViewController* stationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsStationViewController"];
    stationVC.station = [self.stations objectAtIndex:indexPath.row];
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
    
    [self.tableView reloadData];
}

- (IBAction)refreshAction:(id)sender
{
    
}

- (IBAction)showMapAction:(id)sender
{
    if(!self.mapStationsViewController)
    {
        self.mapStationsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
        self.mapStationsViewController.stations = self.stations;
        self.mapStationsViewController.delegate = self;
    }
    
  
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    UIViewAnimationTransition transition = (self.mapShown)? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft;
    [UIView setAnimationTransition:transition
                           forView:self.view
                             cache:NO];
    [UIView commitAnimations];
    if(!self.mapShown)
    {
        //[self.myView removeFromSuperview];
        [self.view addSubview:self.mapStationsViewController.view];
        self.showMapButtonItem.title = @"Liste";
    }
    else
    {
        [self.mapStationsViewController.view removeFromSuperview];
        self.showMapButtonItem.title = @"Carte";
    }
    
    self.mapShown = !self.mapShown;
}

#pragma mark Data CTS Delegate

-(void) didFinishedLoadingData:(NSArray *)stations
{
    [self trieStationsByDistance:stations];
}

-(void) trieStationsByDistance :(NSArray*)stations
{
    self.userLocation = [[CLLocation alloc] initWithLatitude:48.602573 longitude:7.776165];
    
    for (StationVelhop* station in stations)
    {
        CLLocation* stationLoc = [[CLLocation alloc] initWithLatitude:station.coordinate.latitude
                                                            longitude:station.coordinate.longitude];
        station.distanceFromUser = [stationLoc distanceFromLocation:self.userLocation];
    }
    self.stations = [StationVelhop sortArrayOfStations:stations];
    [self.tableView reloadData];
}


#pragma mark Map Delegate

-(void) didSelectedStation:(StationVelhop *)station
{
    StationViewController* stationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsStationViewController"];
    stationVC.station = station;
    [self.navigationController pushViewController:stationVC animated:YES];
}

@end
