//
//  StationAnnotation.h
//  GeoStrass
//
//  Created by amadou diallo on 1/8/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StationVelhop.h"
#import <MapKit/MapKit.h>

@interface StationAnnotation : NSObject<MKAnnotation>

@property(nonatomic,strong) StationVelhop* station;
@property(nonatomic,assign) BOOL userOnBike;

-(id) initWithStation:(StationVelhop*) station;

@end
