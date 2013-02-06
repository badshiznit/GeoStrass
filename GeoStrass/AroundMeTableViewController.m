//
//  AroundMeTableViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "AroundMeTableViewController.h"


@interface AroundMeTableViewController ()

@property(nonatomic,strong) Tram_BusStations* tbs;
@property(nonatomic,strong) NSArray* stations;

@end

@implementation AroundMeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"AroundMeTableViewController viewDidLoad");
    
    self.tbs = [Tram_BusStations stations];
    
    self.stations= [self.tbs.stations allValues];
    
    self.tbs.delegate = self;

    NSLog(@"AroundMeTableViewController viewDidLoad");
}


-(void)didFinishComputeStations:(Tram_BusStations *)tramBusStations
{
    NSLog(@"Receivve Notiff");
    self.stations = [tramBusStations.stations allValues];
    NSLog(@"Stations : %d",self.stations.count);
    
    [self.tableView reloadData];
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
    NSLog(@"numberOfRowsInSection : %d",self.stations.count);
    return self.stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rightDetail";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Station* station = (Station*)[self.stations objectAtIndex:indexPath.row];
   
    cell.textLabel.text = station.stopName;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%d)-%@",indexPath.row,station.stopCode];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
