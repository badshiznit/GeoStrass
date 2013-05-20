//
//  StationVeloCell.m
//  GeoStrass
//
//  Created by amadou diallo on 12/5/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "StationVeloCell.h"
#import "LocalisationMgr.h"
#import <QuartzCore/QuartzCore.h>

#define SHADOW_RADIUS 3.0f
#define SHADOW_OPACITY 0.5f
#define SHADOW_OFFSET CGSizeMake(1.0f, 1.0f)
#define SHADOW_COLOR [[UIColor blackColor] CGColor]

@implementation StationVeloCell

- (void)initViews
{
    self.cellView.layer.shouldRasterize = NO;
    self.cellView.layer.shadowColor = (__bridge CGColorRef)([UIColor colorWithRed:150 green:191 blue:48 alpha:1]);// VELHOP_COLOR_WITH_ALPHA(1);
    self.cellView.layer.shadowOffset = SHADOW_OFFSET;
    self.cellView.layer.shadowOpacity = SHADOW_OPACITY;
    self.cellView.layer.shadowRadius = SHADOW_RADIUS;
    self.cellView.layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cellView.bounds];
    self.cellView.layer.shadowPath = path.CGPath;
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
        alpha = 0.5f;
    self.cbImageView.alpha = alpha;
    
    [self initViews];
}

-(void)computeDistanceFromLocation:(CLLocation*) userLocation
{
    CLLocation* stationLoc = [[CLLocation alloc] initWithLatitude:self.station.coordinate.latitude
                                                        longitude:self.station.coordinate.longitude];
     self.distanceFromUser = [stationLoc distanceFromLocation:userLocation];

    CLLocationDistance dist = self.distanceFromUser;// + 200;
    
    NSString* str = (dist > 1000)? [NSString stringWithFormat:@"%.1f km",dist/1000.0f] : [NSString stringWithFormat:@"%d m",(int)dist];
    
    if(dist < 0)
    {
        str = @"";
    }
    
    self.distanceLabel.text = str;
}

@end
