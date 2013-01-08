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
    
    if(!self.userOnBike)
    {
        int nbAv = station.nbAvailable;
        self.descriptionLabel.text = [NSString stringWithFormat:@"Vélos disponibles : %d",nbAv];
    }
    else
    {
        int nbUsed = station.nbUsed;
        self.descriptionLabel.text = [NSString stringWithFormat:@"Places disponibles : %d",nbUsed];
    }
    
    self.cbImageView.highlighted = station.hasCB;
    CGFloat alpha  = 0;
    if(station.hasCB)
        alpha = 1.0f;
    else
        alpha = 0.1f;
    self.cbImageView.alpha = alpha;
}

-(void)computeDistanceFromLocation:(CLLocation*) userLocation
{
    CLLocation* stationLoc = [[CLLocation alloc] initWithLatitude:self.station.coordinate.latitude
                                                        longitude:self.station.coordinate.longitude];
     self.distanceFromUser = [stationLoc distanceFromLocation:userLocation];

     CLLocationDistance dist = self.distanceFromUser + 200;
    
    NSString* str = (dist > 1000)? [NSString stringWithFormat:@"%.1f km",dist/1000.0f] : [NSString stringWithFormat:@"%d m",(int)dist];
    
    self.distanceLabel.text = str;
}

@end
