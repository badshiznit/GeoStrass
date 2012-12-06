//
//  ListStationsVeloViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "ListStationsVeloViewController.h"

#import "StationVeloCell.h"

@interface ListStationsVeloViewController ()

@property(nonatomic,strong) DataCTS* dataCTS;
@property(nonatomic,strong) NSArray* stations;

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
        [stationCell fillCellWithstation:station];
        CLLocation* userlocation = [[CLLocation alloc] initWithLatitude:48.577303 longitude:7.767091];
        [stationCell computeDistanceFromLocation:userlocation];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)choixModeChange:(id)sender
{
    if(self.choixModeSegmentedcontrol.selectedSegmentIndex == 0)
    {
        self.title = @"Velo";
    }
    else
    {
        self.title = @"Pied";        
    }
}


#pragma mark Data CTS Delegate

-(void) didFinishedLoadingData:(NSArray *)stations
{
    self.stations = stations;
    [self.tableView reloadData];
}

@end
