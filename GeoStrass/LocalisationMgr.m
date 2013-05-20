//
//  Localisation.m
//  GeoStrass
//
//  Created by amadou diallo on 1/11/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "LocalisationMgr.h"



static LocalisationMgr* mgr = nil;

@implementation LocalisationMgr

+ (LocalisationMgr*) mgr {
    @synchronized(self)	{
		if (mgr == nil)
			mgr = [[LocalisationMgr alloc] init];
		return mgr;
	}
	return nil;
}

- (id)init
{
    self = [super init];
 
    if (self)
    {
       // [self locateMe];
    }
    return self;
}

-(void) getUserLocation
{
    if(self.bestEffortAtLocation)
    {
        NSTimeInterval locationAge = -[self.bestEffortAtLocation.timestamp timeIntervalSinceNow];
        NSLog(@"Age best Location = %f",locationAge);
        if(locationAge < 10)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onUserLocationUpdated" object:self.bestEffortAtLocation];
            return;
        }
    }
    
    [self reset];
    
    [self locateMe];
}


-(void)locateMe
{
    // Create the manager object
    if(!self.locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    [self performSelector:@selector(stopUpdatingLocation:) withObject:@"Timed Out" afterDelay:2.0];
    NSLog(@"Updating....");
}

- (void)reset
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.bestEffortAtLocation = nil;
}

#pragma mark Location Manager Interactions

/*
 * We want to get and store a location measurement that meets the desired accuracy. For this example, we are
 *      going to use horizontal accuracy as the deciding factor. In other cases, you may wish to use vertical
 *      accuracy, or both together.
 */
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"didUpdateToLocation : %@",newLocation.description);
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0) return;
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    // test the measurement to see if it is more accurate than the previous measurement
    if (self.bestEffortAtLocation == nil || self.bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        // store the location as the "best effort"
        self.bestEffortAtLocation = newLocation;
        // test the measurement to see if it meets the desired accuracy
        //
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
        // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
        //
        if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            // we have a measurement that meets our requirements, so we can stop updating the location
            //
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
            //
            [self stopUpdatingLocation:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
            // we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:nil];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a
    // timeout that will stop the location manager to save power.
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocation:NSLocalizedString(@"Error", @"Error")];
    }
}

- (void)stopUpdatingLocation:(NSString *)state
{
    NSLog(@"stopUpdatingLocation with state : %@",state);
        
    NSLog(@"Send Best Location to delegate : %@",self.bestEffortAtLocation);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onUserLocationUpdated" object:self.bestEffortAtLocation];
    
    [self reset];
}


@end
