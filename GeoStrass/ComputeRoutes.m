//
//  ComputeRoutes.m
//  GeoStrass
//
//  Created by amadou diallo on 2/28/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "ComputeRoutes.h"
#import "Route.h"
#import "Station.h"

@implementation ComputeRoutes

-(id)init
{
    if(self = [super init])
    {
        self.stopsDict = [[NSMutableDictionary alloc] init];
        self.stopRoutesDict = [[NSMutableDictionary alloc] init];
        self.tripsDict = [[NSMutableDictionary alloc] init];
        self.routesDict = [[NSMutableDictionary alloc] init];
        
        self.busRoutes = [[NSMutableArray alloc] init];
        self.tramRoutes = [[NSMutableArray alloc] init];
        
        [self computeInBckg];
    }
    return self;
}

-(void)computeInBckg
{
    NSLog(@"begin les loulous");
    NSOperationQueue *_computeQueue = [[NSOperationQueue alloc] init];
    _computeQueue.name = @"Parsing des fichiers avec les stations";
    
    [_computeQueue addOperationWithBlock:
     ^(void)
     {
         [self parseRoutes];
         [self parseStops];
         [self parseTrips];
         
         [self findRoutesForStops];
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:^(void)
          {
              //[self print];
              [self writeInFile];
              NSLog(@"fini les loulou");
          }];
     }];
}

-(void) parseRoutes
{
    NSLog(@"parseRoutes ");
    NSString* filePath = @"routes";
    
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    // read everything from text
    NSString* fileContents =
    [NSString stringWithContentsOfFile:fileRoot
                              encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    // then break down even further
    NSString* firstLine =
    [allLinedStrings objectAtIndex:0];
    
    NSArray* keys =
    [firstLine componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@","]];
    
    NSString* strsInOneLine;
    
    for (int i=1; i<allLinedStrings.count; i++)
    {
        strsInOneLine = [allLinedStrings objectAtIndex:i];
        
        NSArray* values =
        [strsInOneLine componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@","]];
        
        NSMutableDictionary* dico = [[NSMutableDictionary alloc] initWithCapacity:keys.count];
        
        for (int j=0; j<values.count; j++)
        {
            //NSLog(@"Set Object : %@ forkey %@ ",[values objectAtIndex:j],[keys objectAtIndex:j]);
            [dico setObject:[values objectAtIndex:j]  forKey:[keys objectAtIndex:j]];
        }
        
        Route* route = [[Route alloc] initWithDictionnary:dico];
        
        [self.routesDict setObject:route forKey:route.routeId]; // route_id
    }
    
    for (Route* route in [self.routesDict allValues])
    {
        if(route.routeType == Bus)
        {
            [self.busRoutes addObject:route];
        }
        else
        {
            if(route.routeType == Tramway)
            {
                [self.tramRoutes addObject:route];
            }
        }
    }
    
    NSLog(@"End parse Routes file : %d Lignes dont %d Trams et %d Bus",self.routesDict.count,self.tramRoutes.count,self.busRoutes.count);
}

-(void) parseStops
{
    
    NSLog(@"parseStops ");
    NSString* filePath = @"stops";
    
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    // read everything from text
    NSString* fileContents =
    [NSString stringWithContentsOfFile:fileRoot
                              encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    // then break down even further
    NSString* firstLine =
    [allLinedStrings objectAtIndex:0];
    
    NSArray* keys =
    [firstLine componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@","]];
    
    NSString* strsInOneLine;
    
    for (int i=1; i<allLinedStrings.count; i++)
    {
        strsInOneLine = [allLinedStrings objectAtIndex:i];
        
        NSArray* values =
        [strsInOneLine componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@","]];
        
        NSMutableDictionary* dico = [[NSMutableDictionary alloc] initWithCapacity:keys.count];
        
        for (int j=0; j<values.count; j++)
        {
            //NSLog(@"Set Object : %@ forkey %@ ",[values objectAtIndex:j],[keys objectAtIndex:j]);
            [dico setObject:[values objectAtIndex:j]  forKey:[keys objectAtIndex:j]];
        }
        
        Station* station = [[Station alloc] initWithDictionnary:dico];
        
        [self.stopsDict setObject:station forKey:station.stopId ]; // stop_id
    }
    
    NSLog(@"End parse Routes file : %d Arrets",self.stopsDict.count);
}

-(void) parseTrips
{
    NSLog(@"parseTrips");
    NSString* filePath = @"trips";
    
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    // read everything from text
    NSString* fileContents =
    [NSString stringWithContentsOfFile:fileRoot
                              encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    // then break down even further
    NSString* firstLine =
    [allLinedStrings objectAtIndex:0];
    
    NSArray* keys =
    [firstLine componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@","]];
    
    NSString* strsInOneLine;
    
    for (int i=1; i<allLinedStrings.count; i++)
    {
        strsInOneLine = [allLinedStrings objectAtIndex:i];
        
        NSArray* values =
        [strsInOneLine componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@","]];
        
        NSMutableDictionary* dico = [[NSMutableDictionary alloc] initWithCapacity:keys.count];
        
        for (int j=0; j<values.count; j++)
        {
            [dico setObject:[values objectAtIndex:j]  forKey:[keys objectAtIndex:j]];
        }
        
//        route_id,service_id,trip_id,trip_headsign,block_id
        [self.tripsDict setObject:[dico objectForKey:@"route_id"] forKey:[dico objectForKey:@"trip_id"]];
    }
    
    NSLog(@"End parse Routes file : %d Arrets",self.stopsDict.count);
}

-(void) findRoutesForStops
{
    NSLog(@"findRoutesForStops");
    NSString* filePath = @"stop_times";
    
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    // read everything from text
    NSString* fileContents =
    [NSString stringWithContentsOfFile:fileRoot
                              encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    // then break down even further
    NSString* firstLine =
    [allLinedStrings objectAtIndex:0];
    
    NSArray* keys =
    [firstLine componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@","]];
    
    NSString* strsInOneLine;
    
    for (int i=1; i<allLinedStrings.count; i++)
    {
        strsInOneLine = [allLinedStrings objectAtIndex:i];
        
        NSArray* values =
        [strsInOneLine componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@","]];
        
        if(values.count > 2)
        {
            NSMutableDictionary* dico = [[NSMutableDictionary alloc] initWithCapacity:keys.count];
            
            for (int j=0; j<values.count; j++)
            {
                [dico setObject:[values objectAtIndex:j]  forKey:[keys objectAtIndex:j]];
            }
            
            [self addRouteFromTripId:[dico objectForKey:@"trip_id"] forStop:[dico objectForKey:@"stop_id"]];
        }
    }
    
    NSLog(@"end findRoutesForStops");
}

-(void) addRouteFromTripId:(NSString*)tripId forStop:(NSString*)stopId
{
   // NSLog(@"addRouteFromTripId");
    NSMutableArray* routes = [self.stopRoutesDict objectForKey:stopId];
    
    if(!routes)
    {
        routes = [[NSMutableArray alloc] init];
    }
    
    NSString* routeId = [self.tripsDict objectForKey:tripId];
    
    if(![routes containsObject:routeId])
    {
        [routes addObject:routeId];
        
        [self.stopRoutesDict setObject:routes forKey:stopId];
    }
}

-(void) print
{
    NSArray* keys = [self.stopRoutesDict allKeys];
    
    for (NSString* stopId in keys)
    {
        NSMutableArray* routes = [self.stopRoutesDict objectForKey:stopId];
        if(routes)
        {
            NSString* stopName = [(Station*)[self.stopsDict objectForKey:stopId] stopName];
            NSLog(@"\nArret : %@  (%d)",stopName,routes.count);
            for (NSString* routeId in routes)
            {
                Route* route = [self.routesDict objectForKey:routeId];
                NSLog(@"Ligne : %@",route.routeLongName);
            }
        }
    }
}


-(void) writeInFile
{
    NSString* textToWrite = @"";
    
    NSArray* keys = [self.stopRoutesDict allKeys];
    for (NSString* stopId in keys)
    {
        NSMutableArray* routes = [self.stopRoutesDict objectForKey:stopId];
        NSString* oneLine = nil;
        if(routes)
        {
            oneLine = [NSString stringWithFormat:@"%@,%d",stopId,routes.count];
            for (NSString* routeId in routes)
            {
                oneLine = [oneLine stringByAppendingFormat:@",%@",routeId];
            }
        }
        if(oneLine)
        {
            textToWrite = [textToWrite stringByAppendingFormat:@"%@\n",oneLine];
        }
    }
    
    NSString *documentsDirectory = @"/Users/amadou.diallo/Documents/projetsFacs/geoStrassGitHub/GeoStrass";
    
    NSError *error;
    BOOL succeed = [textToWrite writeToFile:[documentsDirectory stringByAppendingPathComponent:@"stopsWithRoutes.txt"]
                              atomically:NO encoding:NSUTF8StringEncoding error:&error];
    if (!succeed)
    {
        NSLog(@"Erroooooor");
    }
    else
    {
        NSLog(@"Yahooooooooooooooo");
        NSLog(@"%@",textToWrite);
    }
}


@end
