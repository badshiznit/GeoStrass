//
//  Route.m
//  GeoStrass
//
//  Created by amadou diallo on 2/19/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "Route.h"

@implementation Route

-(id) initWithDictionnary:(NSDictionary*) dico
{
    self = [super init];
    if(self)
    {
     //     NSLog(@"Route initWithDictionnary %@",dico.description);
        self.routeId        = [dico objectForKey:@"route_id"];
        self.routeShortName = [dico objectForKey:@"route_short_name"];
        self.routeLongName  = [dico objectForKey:@"route_long_name"];
        self.routeType      = [self getRoutetypeFrom:[dico objectForKey:@"route_type"]];
        self.routecolor     = [self colorWithHex:[dico objectForKey:@"route_color"]];
        self.routeTextColor = [self colorWithHex:[dico objectForKey:@"route_text_color"]];
        [self fillDirections];
    }
    return self;
}

-(UIColor*) colorWithHex:(NSString*)colorString
{
    int color = [colorString intValue];
    
  //  NSLog(@"Colord Hex = %d",color);
    
    float red = (color & 0xff000000) >> 24;
    float green = (color & 0x00ff0000) >> 16;
    float blue = (color & 0x0000ff00) >> 8;
    float alpha = (color & 0x000000ff);
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}

-(RouteType) getRoutetypeFrom:(NSString*) string
{
    if([string isEqualToString:@"3"])
        return Bus ;
    if([string isEqualToString:@"0"])
        return Tramway ;
    
    return Unknown ;
}

-(void) fillDirections
{
   // NSLog(@"Direction : %@",self.routeLongName);
    NSArray* values =
    [self.routeLongName componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@"-"]];
    if(values.count == 2)
    {
        self.oneWayDirection = (NSString*) [values objectAtIndex:0];
        self.returnWayDirection = (NSString*) [values objectAtIndex:1];
    }
    else
    {
        self.oneWayDirection = @"Aller inconnu";
        self.returnWayDirection = @"Retour nop";
    }
}

@end
