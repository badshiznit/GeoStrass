//
//  Localisation.h
//  GeoStrass
//
//  Created by amadou diallo on 1/11/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define VELHOP_COLOR_WITH_ALPHA(a) RGBA(150.0,191.0,48.0,a)

/*
@class LocalisationMgr;

@protocol LocalisationMgrDelegate <NSObject>

@required

-(void) didFindUserLocation:(CLLocation*) userLocation;

@end*/

@interface LocalisationMgr : NSObject<CLLocationManagerDelegate>

//@property(nonatomic,strong) id<LocalisationMgrDelegate> delegate;

@property(nonatomic,strong) CLLocationManager* locationManager;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;
@property (nonatomic,strong) CLPlacemark* placemark;

-(void)locateMe;
+ (LocalisationMgr*) mgr;
-(void) getUserLocation;

@end
