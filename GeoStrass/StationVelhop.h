//
//  StationVelhop.h
//  GeoStrass
//
//  Created by amadou diallo on 12/5/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface StationVelhop : NSObject

@property(nonatomic,strong) NSString* sid;
@property(nonatomic,strong) NSString* name;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,assign) NSInteger nbAvailable;
@property(nonatomic,assign) NSInteger nbUsed;
@property(nonatomic,assign) NSInteger nbTotal;
@property(nonatomic,assign) BOOL hasCB;

-(id) initWithId:(NSString*)sid
            name:(NSString*)name
      coordinate:(CLLocationCoordinate2D) coordinate
nbAvailableBikes:(NSInteger)nbAvailable
     nbUsedBikes:(NSInteger)nbUsed
    nbTotalBikes:(NSInteger)nbTotal
        andHasCB:(BOOL) hasCB;



@end
