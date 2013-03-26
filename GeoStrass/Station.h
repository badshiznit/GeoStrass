//
//  Station.h
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalisationMgr.h"

@interface Station : NSObject

@property(nonatomic,strong) NSString* stopId;
@property(nonatomic,strong) NSString* stopCode;
@property(nonatomic,strong) NSString* stopLatitude;
@property(nonatomic,strong) NSString* stopLongitude;
@property(nonatomic,strong) NSString* stopName;
@property(nonatomic,strong) NSString* stopUrl;

@property(nonatomic,strong) CLLocation* stopLocation;
@property(nonatomic,strong) CLLocation* userLocation;
@property(nonatomic,assign) CLLocationDistance distanceFromUser;

@property(nonatomic,strong) NSMutableArray* routes;

-(id) initWithDictionnary:(NSDictionary*) dico;
-(void)computeDistanceFromUser:(CLLocation*) userLocation;
+(NSArray*)sortArrayOfStations:(NSArray*) stations fromLocation:(CLLocation*) userLocation;

@end
