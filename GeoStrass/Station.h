//
//  Station.h
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property(nonatomic,strong) NSString* stopId;
@property(nonatomic,strong) NSString* stopCode;
@property(nonatomic,strong) NSString* stopLatitude;
@property(nonatomic,strong) NSString* stopLongitude;
@property(nonatomic,strong) NSString* stopName;
@property(nonatomic,strong) NSString* stopUrl;

-(id) initWithDictionnary:(NSDictionary*) dico;

@end
