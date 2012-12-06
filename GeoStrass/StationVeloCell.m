//
//  StationVeloCell.m
//  GeoStrass
//
//  Created by amadou diallo on 12/5/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "StationVeloCell.h"

@implementation StationVeloCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void) fillCellWithstation:(StationVelhop*) station
{
    self.station = station;
    self.nameLabel.text = [station.name substringFromIndex:4];
    int nbAv = station.nbAvailable;
    int nbTot = station.nbTotal;
    self.descriptionLabel.text = [NSString stringWithFormat:@"%d Vélos disponibles sur %d",nbAv, nbTot];
}

-(void)computeDistanceFromLocation:(CLLocation*) userLocation
{
    CLLocation* stationLoc = [[CLLocation alloc] initWithLatitude:self.station.coordinate.latitude
                                                        longitude:self.station.coordinate.longitude];
    CLLocationDistance dist = [stationLoc distanceFromLocation:userLocation];
    
    NSLog(@"Je suis à %f m de la station %@",dist,self.station.name);
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%d m",(int)dist ];
}

@end
