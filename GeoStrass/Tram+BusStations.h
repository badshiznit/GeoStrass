//
//  Tram+BusStations.h
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@class Tram_BusStations;

@protocol Tram_BusStationsDelegate <NSObject>

-(void) didFinishComputeStations:(Tram_BusStations*) tramBusStations;

@end

@interface Tram_BusStations : NSObject

@property(nonatomic,strong) id<Tram_BusStationsDelegate> delegate;
@property(nonatomic,strong) NSMutableDictionary* stations;
@property(nonatomic,strong) NSMutableDictionary* joinedStations;

+(Tram_BusStations*) stations;

@end
