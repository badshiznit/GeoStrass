//
//  SuperStation.h
//  GeoStrass
//
//  Created by amadou diallo on 3/4/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"
#import <CoreLocation/CoreLocation.h>

@interface SuperStation : NSObject

@property(nonatomic,strong) NSMutableArray* stations;
@property(nonatomic,strong) NSMutableArray* routes;
@property(nonatomic,strong) NSMutableArray* busRoutes;
@property(nonatomic,strong) NSMutableArray* tramRoutes;
@property(nonatomic,strong) NSString* name;

@property(nonatomic,assign) CLLocationDistance distanceFromUser;
@property(nonatomic,strong) NSString* category;
@property(nonatomic,assign) BOOL hasBus;
@property(nonatomic,assign) BOOL hasTram;

-(void)computeDistanceFromUser:(CLLocation*) userLocation;
+(NSArray*)sortArrayOfStations:(NSArray*) stations fromLocation:(CLLocation*) userLocation;
-(id)initWithStations:(NSMutableArray*) stations;
-(void) loadStations;

-(void)print;

@end
