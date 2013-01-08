//
//  MapStationsViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 11/22/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "MapStationsViewController.h"

#import "StationViewController.h"
#import "StationAnnotation.h"

@interface MapStationsViewController ()

@end

@implementation MapStationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
  self.mapView.showsUserLocation = YES;
}

-(void) viewWillDisappear:(BOOL)animated
{
  self.mapView.showsUserLocation = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    for (StationVelhop* station in self.stations)
    {
        StationAnnotation* annotation = [[StationAnnotation alloc] initWithStation:station];
        [self.mapView addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showLocation:(CLLocation*) locationToShow
{
    double miles = 10.0;
    double scalingFactor = ABS( (cos(2 * M_PI * locationToShow.coordinate.latitude / 360.0) ));
    
    MKCoordinateSpan span;
    
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    MKCoordinateRegion region;
    region.span = span;
    CLLocationCoordinate2D center =
    CLLocationCoordinate2DMake(locationToShow.coordinate.latitude, locationToShow.coordinate.longitude);
    region.center = center;
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)showUserLocation:(id)sender
{
    if(self.stations)
    {
        StationVelhop* st = [self.stations objectAtIndex:0];
        CLLocation* loc = [[CLLocation alloc] initWithLatitude:st.coordinate.latitude longitude:st.coordinate.longitude];
        [self showLocation:loc];
    }
    else
        [self showLocation:self.mapView.userLocation.location];
}

#pragma mark - MapView Cell Delegate

-(void) performGeocodeFromLocation:(CLLocation*) location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        NSLog(@"Received placemarks in RoutingVC: %@", placemarks);
//        CLPlacemark* placemark = [placemarks lastObject];
    }];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if (mapView.userLocation == view.annotation)
    {
        mapView.userLocation.title = @"Je suis ici";
    }
    else
    {
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if(annotation == mapView.userLocation)
    {
         annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    StationAnnotation* stAnn = (StationAnnotation*) view.annotation;
    NSLog(@"calloutAccessoryControlTapped : %@",stAnn.station.name);
    [self.delegate didSelectedStation:stAnn.station];
}


@end
