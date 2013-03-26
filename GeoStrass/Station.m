//
//  Station.m
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "Station.h"

@implementation Station

-(id) initWithDictionnary:(NSDictionary*) dico
{
    self = [super init];
    if(self)
    {
      //  NSLog(@"Station initWithDictionnary %@",dico.description);
        self.stopId        = [dico objectForKey:@"stop_id"];
        self.stopCode      = [dico objectForKey:@"stop_code"];
        self.stopLatitude  = [dico objectForKey:@"stop_lat"];
        self.stopLongitude = [dico objectForKey:@"stop_lon"];
        self.stopName      = [self formatstopName:[dico objectForKey:@"stop_name"]];
        self.stopUrl       = [dico objectForKey:@"stop_url"];
        [self getLocation];
    }
    return self;
}

-(NSString*) formatstopName:(NSString*) str
{    
    NSString* res = [str stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    
    res = [res stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return res;    
}



-(void) getLocation
{
    self.stopLocation = [[CLLocation alloc] initWithLatitude: [self.stopLatitude floatValue]  longitude:[self.stopLongitude floatValue]];
    //NSLog(@"Compute Location 1 = %f %f ",self.stopLocation.coordinate.longitude,self.stopLocation.coordinate.latitude);
}

-(void)computeDistanceFromUser:(CLLocation*) userLocation
{
  //  NSLog(@"Compute Location 1 = %f %f     userLocation 2 = %f %f",self.stopLocation.coordinate.longitude,self.stopLocation.coordinate.latitude, userLocation.coordinate.longitude,userLocation.coordinate.latitude);
    self.distanceFromUser = [self.stopLocation distanceFromLocation:userLocation];
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


@end
