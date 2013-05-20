//
//  StationInfosViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 4/11/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperStation.h"
#import "ServiceSvc.h"

@interface NextPassagesViewController : UIViewController<UIScrollViewDelegate,ServiceSoapBindingResponseDelegate>

@property(nonatomic,strong) SuperStation* station;
@property(nonatomic,strong) NSString* selectedRouteShortName;

@property (strong, nonatomic) IBOutlet UIScrollView *routesScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *detailsScrollView;

@end
