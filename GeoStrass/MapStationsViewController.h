//
//  MapStationsViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "StationVelhop.h"

@class MapStationsViewController;

@protocol MapStationsViewControllerDelegate <NSObject>

@required

-(void) didSelectedStation:(StationVelhop*) station;

@end


@interface MapStationsViewController : UIViewController<MKMapViewDelegate,MKAnnotation>

@property(nonatomic,strong) id<MapStationsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *vieww;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSArray* stations;

- (IBAction)showUserLocation:(id)sender;

@end
