//
//  StationVelhop.m
//  GeoStrass
//
//  Created by amadou diallo on 12/5/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "StationVelhop.h"

@implementation StationVelhop

-(id) initWithId:(NSString*)sid
            name:(NSString*)name
      coordinate:(CLLocationCoordinate2D) coordinate
nbAvailableBikes:(NSInteger)nbAvailable
     nbUsedBikes:(NSInteger)nbUsed
    nbTotalBikes:(NSInteger)nbTotal
        andHasCB:(BOOL) hasCB
{
    self = [super init];
    if(self)
    {
        self.sid = sid;
        self.coordinate = coordinate;
        self.nbAvailable = nbAvailable;
        self.nbUsed = nbUsed;
        self.name = name;
        self.nbTotal = nbTotal;
        self.hasCB = hasCB;
    }
    return self;
}


@end
