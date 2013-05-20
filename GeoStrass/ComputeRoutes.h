//
//  ComputeRoutes.h
//  GeoStrass
//
//  Created by amadou diallo on 2/28/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComputeRoutes : NSObject

/*
@property(nonatomic,strong) NSMutableArray* routes; // lignes : route_id,route_short_name,route_long_name,route_desc,route_type
@property(nonatomic,strong) NSMutableArray* stops;  // arrets : stop_id,stop_code,stop_lat,stop_lon,stop_name,stop_url
@property(nonatomic,strong) NSMutableArray* trips;  // Voyages possibles : route_id,service_id,trip_id,trip_headsign,block_id */

@property(nonatomic,strong) NSMutableDictionary* tripsDict; // (key=trip_id, Value=route_id)
@property(nonatomic,strong) NSMutableDictionary* stopRoutesDict; // Key=stop_id Value=route_id
@property(nonatomic,strong) NSMutableDictionary* routesDict; // Key=stop_id Value=route_id
@property(nonatomic,strong) NSMutableDictionary* stopsDict; // Key=stop_id Value=route_id

@property(nonatomic,strong) NSMutableArray* busRoutes;
@property(nonatomic,strong) NSMutableArray* tramRoutes;

@end
