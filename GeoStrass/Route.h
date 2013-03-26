//
//  Route.h
//  GeoStrass
//
//  Created by amadou diallo on 2/19/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    Bus,
    Tramway,
    Unknown
};

typedef NSInteger RouteType;

@interface Route : NSObject

@property(nonatomic,strong) NSString* routeId;
@property(nonatomic,strong) NSString* routeShortName;
@property(nonatomic,strong) NSString* routeLongName;
@property(nonatomic,assign) RouteType routeType;
@property(nonatomic,strong) UIColor* routecolor;
@property(nonatomic,strong) UIColor* routeTextColor;

@property(nonatomic,strong) NSString* oneWayDirection;
@property(nonatomic,strong) NSString* returnWayDirection;

-(id) initWithDictionnary:(NSDictionary*) dico;

@end
