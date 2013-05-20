//
//  StationInfosViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 4/11/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "NextPassagesViewController.h"
#import "Route.h"
#import "RouteNextTimeViewController.h"

@interface NextPassagesViewController ()

@property(nonatomic,strong) NSArray* routes;
@property(nonatomic,strong) NSMutableArray* routesViewControllers;
@property(nonatomic,strong) UISegmentedControl* wichRouteSegmentedControl;

@property(nonatomic,strong) ServiceSoapBinding *ctsSoapBinding;

@property(nonatomic,assign) BOOL isUp;

@end

@implementation NextPassagesViewController

-(void)moveViewDown
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; // if you want to slide up the view
    
    CGRect rect = self.detailsScrollView.frame;
    rect.origin.y += 95;
    rect.size.height -= 95;
    self.detailsScrollView.frame = rect;
    
    [UIView commitAnimations];
}

-(void)moveViewUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; // if you want to slide up the view
    
    CGRect rect = self.detailsScrollView.frame;
    rect.origin.y -= 95;
    rect.size.height += 95;
    self.detailsScrollView.frame = rect;
    
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect myFrame = self.routesScrollView.bounds;
   
    _routesViewControllers = [[NSMutableArray alloc] init];
    _routes = [self.station.tramRoutes arrayByAddingObjectsFromArray:self.station.busRoutes];
    NSMutableArray* segments = [[NSMutableArray alloc] init];
    for (Route* route in _routes)
    {
        [segments addObject:route.routeShortName];
    }
    
    self.wichRouteSegmentedControl = [[UISegmentedControl alloc] initWithItems:segments];

    [self.wichRouteSegmentedControl addTarget:self action:@selector(kindOfRouteChanged:) forControlEvents:UIControlEventValueChanged];
    self.wichRouteSegmentedControl.frame = myFrame;
    
    [self.routesScrollView addSubview:self.wichRouteSegmentedControl];
    
    CGRect contentFrame = self.routesScrollView.frame;
    contentFrame.size.width += 20;
    self.routesScrollView.contentSize = contentFrame.size;
    
    CGRect frame = self.routesScrollView.frame;
    frame.origin.x = self.routesScrollView.frame.size.width / 2 - self.wichRouteSegmentedControl.frame.size.width/2;
    
    self.title = self.station.name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Details" style:UIBarButtonItemStyleBordered target:self action:@selector(showMoreOrLess:)];
    
    [self loadViews];
    
    BOOL hasSelected = NO;
    for (int i=0; i<_wichRouteSegmentedControl.numberOfSegments; i++) {
        NSString* scope = [_wichRouteSegmentedControl titleForSegmentAtIndex:i];
        if([scope isEqualToString:_selectedRouteShortName])
        {
            [self.wichRouteSegmentedControl setSelectedSegmentIndex:i];
            hasSelected = YES;
        }
    }
    if(!hasSelected)
    {
        [_wichRouteSegmentedControl setSelectedSegmentIndex:0];
    }
    
    [self updateRoute];
    
    _ctsSoapBinding = [ServiceSvc ServiceSoapBinding];
    _ctsSoapBinding.logXMLInOut = YES;
    
    [self sendRequest]; 
}

-(void)showMoreOrLess:(id)sender
{
    NSLog(@"showMoreOrLess");
    if(_isUp)
    {
        [self moveViewDown];
    }
    else
    {
        [self moveViewUp];
    }
    
    _isUp = !_isUp;
}

-(void) loadViews
{
    CGFloat _scrollHeightOff = (IS_IPHONE_4)? 88 : ((IS_IPHONE_5)? 0 : 88);
    
    CGRect frame = self.detailsScrollView.frame;
    frame.size.height -= _scrollHeightOff;
    self.detailsScrollView.frame = frame;
    
    int i = 0;
    for (Route* route in _routes)
    {
        RouteNextTimeViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"RouteNextTimeViewController"];
        if(controller)
        {
            controller.route = route;
            controller.tableView.frame = CGRectMake(320*i++, 0, 320, self.detailsScrollView.frame.size.height);
            [self.detailsScrollView addSubview:controller.tableView];
            [self.routesViewControllers addObject:controller];
        }
    }
    CGFloat scrollWidth = 320 * self.routesViewControllers.count;
    self.detailsScrollView.contentSize = CGSizeMake(scrollWidth, self.detailsScrollView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.wichRouteSegmentedControl setSelectedSegmentIndex:page];
}

- (void)kindOfRouteChanged:(id)sender
{
    CGRect frame = self.detailsScrollView.frame;
    frame.origin.x = frame.size.width * self.wichRouteSegmentedControl.selectedSegmentIndex;
    frame.origin.y = 0;
    [self.detailsScrollView scrollRectToVisible:frame animated:YES];
}

- (void)updateRoute
{
    CGRect frame = self.detailsScrollView.frame;
    frame.origin.x = frame.size.width * self.wichRouteSegmentedControl.selectedSegmentIndex;
    frame.origin.y = 0;
    [self.detailsScrollView scrollRectToVisible:frame animated:YES];
}

-(void) sendRequest
{
    NSMutableArray* codes = [[NSMutableArray alloc] initWithCapacity:_station.stations.count];

    for (Station* station in _station.stations)
    {
        NSString *code = [self removeLetters:station.stopCode];
        
        if (![codes containsObject:code])
        {
            [codes addObject:code];
        }
    }
    for (NSString* code in codes)
    {
        [self sendSoapWithStopId:code];
        NSLog(@"Request sent with Code : %@",code);
    }
}

-(NSString*) removeLetters:(NSString*)originalString
{
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:originalString.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return strippedString;
}

- (void)sendSoapWithStopId:(NSString*) stopId
{
    _ctsSoapBinding.authUsername = @"amadou.diallo@etu.unistra.fr";
    _ctsSoapBinding.authPassword = @"master";
    
    ServiceSvc_rechercheProchainesArriveesWeb* prochainArriveeService = [[ServiceSvc_rechercheProchainesArriveesWeb alloc]init];
    prochainArriveeService.CodeArret = stopId;
    prochainArriveeService.Mode = [NSNumber numberWithInt:2];
    prochainArriveeService.NbHoraires = [NSNumber numberWithInt:2];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    prochainArriveeService.Heure = [formatter stringFromDate:[NSDate date]];
    
    ServiceSvc_CredentialHeader* credentials = [[ServiceSvc_CredentialHeader alloc] init];
    credentials.ID_ = @"43";
    credentials.MDP = @"master";
    
    [_ctsSoapBinding rechercheProchainesArriveesWebAsyncUsingParameters:prochainArriveeService CredentialHeader:credentials CredentialHeader:credentials delegate:self];
}


-(void) operation:(ServiceSoapBindingOperation *)operation completedWithResponse:(ServiceSoapBindingResponse *)response
{
    NSLog(@"Operation = %@, response = %@",operation.description,response.description);
    
    for (id rep in response.headers)
    {
       // NSLog(@"Header = %@",rep);
    }
    
   // NSLog(@"Error = %@",response.error.description);
    
    for (id rep in response.bodyParts)
    {
        NSLog(@"BodyPart = %@",rep);
        ServiceSvc_rechercheProchainesArriveesWebResponse* response = (ServiceSvc_rechercheProchainesArriveesWebResponse*)rep;
        if([response isKindOfClass:[ServiceSvc_rechercheProchainesArriveesWebResponse class]])
        {
            NSLog(@"NbProchains arrivee = %d",response.rechercheProchainesArriveesWebResult.ListeArrivee.Arrivee.count);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onResultCome"
                                                                object:response.rechercheProchainesArriveesWebResult.ListeArrivee.Arrivee];
            
            for (id arr in response.rechercheProchainesArriveesWebResult.ListeArrivee.Arrivee)
            {
                ServiceSvc_Arrivee* arrivee = (ServiceSvc_Arrivee*)arr;
                NSLog(@"Destination = %@, heure = %@, Mode = %@",arrivee.Destination,arrivee.Horaire,arrivee.Mode);
            }
        }
    }
}

@end
