//
//  StationViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 1/8/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "StationViewController.h"

@interface StationViewController ()

@end

@implementation StationViewController

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
    self.title = [self.station.name substringFromIndex:4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 4;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stationCell";
    
    switch (indexPath.section) {
        case 0:
            CellIdentifier = @"rightDetailCell";
            break;
        case 1:
            CellIdentifier = @"goViaMapCell";
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.station.nbAvailable];
                cell.textLabel.text = @"Vélos disponibles";
            }
            if(indexPath.row == 1)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.station.nbUsed];
                cell.textLabel.text = @"Places disponibles";
            }
            if(indexPath.row == 2)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.station.nbTotal];
                cell.textLabel.text = @"Capacité de la station";
            }
            if(indexPath.row == 3)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:(self.station.hasCB)?@"Oui":@"Non"];
                cell.textLabel.text = @"Paiement avec la CB";
            }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
