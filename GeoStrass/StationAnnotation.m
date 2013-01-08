//
//  StationAnnotation.m
//  GeoStrass
//
//  Created by amadou diallo on 1/8/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "StationAnnotation.h"

@implementation StationAnnotation

-(id) initWithStation:(StationVelhop*) station
{
    if ((self = [super init]))
    {
        self.station = station;
    }
    return self;
}

- (NSString *)title
{
    return [NSString stringWithFormat:@"%@",self.station.name];
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"Places disponibles : %d",self.station.nbAvailable];
}

- (CLLocationCoordinate2D)coordinate
{
    return self.station.coordinate;
}


@end
