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

+(NSArray*)sortArrayOfStations:(NSArray*) stations
{
    NSMutableArray* tmp = [[NSMutableArray alloc] initWithArray:stations];
    
    NSLog(@"Unsorted ");
    for (StationVelhop* s in tmp)
    {
        NSLog(@"Station : %@ est à %f",s.name,s.distanceFromUser);
    }

    return [tmp sortedArrayUsingSelector:@selector(compare:)];
}

-(NSComparisonResult) compare:(StationVelhop*) station
{
    if(self.distanceFromUser > station.distanceFromUser)
    {
        return NSOrderedDescending;
    }
    else
    {
        if(self.distanceFromUser < station.distanceFromUser)
        {
            return NSOrderedAscending;
        }
    }
    return NSOrderedSame;
}

@end
