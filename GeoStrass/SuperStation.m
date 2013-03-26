//
//  SuperStation.m
//  GeoStrass
//
//  Created by amadou diallo on 3/4/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "SuperStation.h"
#import "Route.h"

@implementation SuperStation

-(id)initWithStations:(NSMutableArray*) stations
{
    if(self = [super init])
    {
        self.stations = stations;
        
        self.name = [(Station*)[stations lastObject] stopName];
        
        self.busRoutes = [[NSMutableArray alloc] init];
        self.tramRoutes = [[NSMutableArray alloc] init];
        self.routes = [[NSMutableArray alloc] init];
        
        [self loadStations];
        
        self.hasBus = self.busRoutes.count > 0;
        self.hasTram = self.tramRoutes.count > 0;
        self.category = @"";
        if(self.hasTram)
        {
            self.category = [self.category stringByAppendingString:@" Trams "];
        }
        
        if(self.hasBus)
        {
            self.category = [self.category stringByAppendingString:@" Bus "];
        }
    }
    
    return self;
}

-(void) loadStations
{
    for (Station* st in self.stations)
    {
        if([st.stopName isEqualToString:@"Temple"])
            NSLog(@"Arret : %@",st.stopName);
        
        for (Route* route in st.routes)
        {
            if(![self lookIfRoute:route isPresentInArray:self.routes])
                [self.routes addObject:route];
            
            if(route.routeType == Bus)
            {
                if(![self lookIfRoute:route isPresentInArray:self.busRoutes])
                    [self.busRoutes addObject:route];
            }
            
            if(route.routeType == Tramway)
            {
                if(![self lookIfRoute:route isPresentInArray:self.tramRoutes])
                    [self.tramRoutes addObject:route];
            }
        }
    }
}

-(BOOL) lookIfRoute:(Route*) route isPresentInArray:(NSMutableArray*) array
{
    for (Route* oneRoute in array)
    {
        if (oneRoute)
        {
            if([oneRoute.routeShortName isEqualToString:route.routeShortName])
                return YES;
        }
    }
    
    return NO;
}

-(void)computeDistanceFromUser:(CLLocation*) userLocation
{
    Station* station = [self.stations lastObject];
    //NSLog(@"Compute distance from UserLocation : %@ to %@",userLocation.description,station.stopLocation.description);
    self.distanceFromUser = [station.stopLocation distanceFromLocation:userLocation];
    
    NSLog(@"Distance = %f",self.distanceFromUser);
}

+(NSArray*)sortArrayOfStations:(NSArray*) stations fromLocation:(CLLocation*) userLocation
{
    NSMutableArray* tmp = [[NSMutableArray alloc] initWithArray:stations];
    
    NSLog(@"Unsorted ");
    
    for (Station* s in tmp)
    {
        [s computeDistanceFromUser:userLocation];
    }
    
    return [tmp sortedArrayUsingSelector:@selector(compare:)];
}

-(NSComparisonResult) compare:(Station*) station
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

-(void)print
{
    NSLog(@"\nSuper Station : %@",self.name);
    NSLog(@"Stations Totales : %d dont %d Bus et %d Trams",self.stations.count, self.busRoutes.count,self.tramRoutes.count);
    
    for (Station* st in self.stations)
    {
        NSLog(@"Station : %@",st.stopName);
        for (Route* route in st.routes)
        {
            NSLog(@"Route ShortName : %@ ----> estUnBus = %d",route.routeShortName,route.routeType);
        }
    }
}

@end
