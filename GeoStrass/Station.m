//
//  Station.m
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "Station.h"

@implementation Station

-(id) initWithDictionnary:(NSDictionary*) dico
{
    self = [super init];
    if(self)
    {
      //  NSLog(@"Station initWithDictionnary %@",dico.description);
        self.stopId        = [dico objectForKey:@"stop_id"];
        self.stopCode      = [dico objectForKey:@"stop_code"];
        self.stopLatitude  = [dico objectForKey:@"stop_latitude"];
        self.stopLongitude = [dico objectForKey:@"stop_longitude"];
        self.stopName      = [dico objectForKey:@"stop_name"];
        self.stopUrl       = [dico objectForKey:@"stop_url"];
    }
    return self;
}

@end
