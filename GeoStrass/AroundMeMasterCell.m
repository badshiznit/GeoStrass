//
//  AroundMeMasterCell.m
//  GeoStrass
//
//  Created by amadou diallo on 3/4/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "AroundMeMasterCell.h"


@implementation AroundMeMasterCell

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"gestureRecognizerShouldBegin");
    return YES;
}

-(void) setMasterStation:(SuperStation *)masterStation withScope:(NSInteger)scope
{
    if(_masterStation)
    {
        _masterStation = nil;
        NSArray* subviews = [self.routesView subviews];
        for (int i=1; i<subviews.count; i++) {
            [[subviews objectAtIndex:i] removeFromSuperview];
        }
        self.firstImageV.image = [UIImage imageNamed:@"tram.jpg"];
    }
    _masterStation = masterStation;
    self.nameLabel.text = masterStation.name;
    
    CLLocationDistance dist = _masterStation.distanceFromUser;
    self.distanceLabel.text = (dist > 1000)? [NSString stringWithFormat:@"%.1f km",dist/1000.0f] : [NSString stringWithFormat:@"%d m",(int)dist];
    
    if(scope==0)
    {
        [self showTrams];
        [self showBus];
    }
    else
    {
        if(scope==1)
        {
            [self showTrams];
        }
        else
        {
            if(scope==2)
            {
                [self showBus];
            }
        }
    }
    
    CGFloat scrollHeight = self.routesView.frame.size.height;
    CGFloat scrollWidth = _masterStation.tramRoutes.count * 30 + 40*3 + _masterStation.busRoutes.count*40;
    self.routesView.contentSize = CGSizeMake(scrollWidth, scrollHeight);
    
    [_masterStation loadStations];
}


-(void)showTrams
{
    for (int i=0; i<_masterStation.tramRoutes.count; i++)
    {
        if(i==0)
        {
            self.firstImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tram.jpg"]];
            CGRect ref = self.routesView.frame;
            ref.size = CGSizeMake(40, 30);
            self.firstImageV.frame = ref;
            [self.routesView addSubview:self.firstImageV];
        }
        
        Route* route = (Route*)[_masterStation.tramRoutes objectAtIndex:i];
        
        UIImageView* imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",route.routeShortName]]];
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnTram:)];
       
        tapped.numberOfTapsRequired = 1;
        [imageV addGestureRecognizer:tapped];
         tapped.view.tag = i;
        CGRect rectInit = self.firstImageV.frame;
        imageV.frame = CGRectMake(rectInit.origin.x + 40 + i*30, rectInit.origin.y, 30, 30);
        
        [self.routesView addSubview:imageV];
    }

}
-(void)showBus
{
    UIImageView* busImageV;
    for (int i=0; i<_masterStation.busRoutes.count; i++)
    {
        if(i==0)
        {
            if(_masterStation.tramRoutes.count == 0)
            {
                self.firstImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bus.jpg"]];
                CGRect ref = self.routesView.frame;
                ref.size = CGSizeMake(40, 30);
                self.firstImageV.frame = ref;
                busImageV = self.firstImageV;
            }
            else
            {
                busImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bus.jpg"]];
                CGRect reference = self.firstImageV.frame;
                reference.origin.x += 40 + _masterStation.tramRoutes.count*30 + 10;
                busImageV.frame = reference;
            }
            
            [self.routesView addSubview:busImageV];
        }
        
        Route* route = (Route*)[_masterStation.busRoutes objectAtIndex:i];
        
        UIImageView* imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",route.routeShortName]]];
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBus:)];
        
        tapped.numberOfTapsRequired = 1;
        [imageV addGestureRecognizer:tapped];
        tapped.view.tag = i;
        CGRect rectInit = busImageV.frame;
        
        CGFloat decalage = rectInit.origin.x + 40 + i*40;
        imageV.frame = CGRectMake(decalage, rectInit.origin.y, 40, 30);
        
        [self.routesView addSubview:imageV];
    }
}
-(void)showNavettes
{
    
}

-(void) setSelectedWithRoute:(Route*)route
{
    self.selectedRoute = route;
    [self.delegate didSelectRouteAtCell:self];

}

-(void) tapOnBus:(id) sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    int index = gesture.view.tag;
    Route* route = (Route*)[_masterStation.busRoutes objectAtIndex:index];
    NSLog(@"tapOnBus %d : %@      %@",index,route.routeShortName,gesture.description);
    
    [self setSelectedWithRoute:route];
}

-(void) tapOnTram:(id) sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    int index = gesture.view.tag;
    Route* route = (Route*)[_masterStation.tramRoutes objectAtIndex:index];
    NSLog(@"tapOnTram %d : %@",index,route.routeShortName);
    
        [self setSelectedWithRoute:route];
}

@end
