//
//  RouteNextTimeViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 4/12/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "RouteNextTimeViewController.h"

@interface RouteNextTimeViewController ()

@property(nonatomic,strong) NSMutableArray* directions;

@end

@implementation RouteNextTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onResultCome:)
                                                 name:@"onResultCome" object:nil];
}

- (void)onResultCome:(NSNotification*)notification
{
    NSArray* arrivees = (NSArray*)notification.object;
    _directions = [[NSMutableArray alloc] init];
    for (id arr in arrivees)
    {
        ServiceSvc_Arrivee* arrivee = (ServiceSvc_Arrivee*)arr;
        NSLog(@"Destination = %@, heure = %@, Mode = %@",arrivee.Destination,arrivee.Horaire,arrivee.Mode);
        
        NSArray* values =
        [arrivee.Destination componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@" "]];
        if([[values objectAtIndex:0] isEqualToString:self.route.routeShortName])
        {
            [_directions addObject:arrivee];
        }
            
    }
    
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
    return _directions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ServiceSvc_Arrivee* arrivee = (ServiceSvc_Arrivee*)_directions[indexPath.row];
       
    cell.textLabel.text = arrivee.Destination;
    cell.detailTextLabel.text = arrivee.Horaire;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
