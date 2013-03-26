//
//  Tram+BusStations.m
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "Tram+BusStations.h"
#import "RoutesTableViewController.h"

@implementation Tram_BusStations

static Tram_BusStations* stations;

+ (Tram_BusStations *)stations
{
    if (stations == nil) {
        stations = [[Tram_BusStations alloc] initWithStopStations:@"stops"];
    }
    return stations;
}

-(id) initWithStopStations:(NSString*) fileName
{
    self = [super init];
    if(self)
    {
        self.stations = [[NSMutableDictionary alloc] init];
        
        [self _executeToTheBackground];
    }
    return self;
}


-(void)_executeToTheBackground
{
    NSLog(@"begin _executeToTheBackground");
    NSOperationQueue *_computeQueue = [[NSOperationQueue alloc] init];
    _computeQueue.name = @"Parsing des fichiers avec les stations";
    
    [_computeQueue addOperationWithBlock:
    ^(void)
    {
        [self parseFile:@"stops"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void)
        {
            [self.delegate didFinishComputeStations:self];
             NSLog(@"didFinishComputeStations sent : %d",self.stations.count);
        }];
    }];
}


-(void) parseFile:(NSString*) filePath
{
    NSLog(@"begin parse file : %@",filePath);
    
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
        
        [self.stations setObject:station forKey:station.stopId]; // Stop_id
    }
    NSLog(@"end parse file : %@ with content : %d",filePath,self.stations.count);

    [self parseStopsWithRoutes];
    
    [self joinStations];
}

-(void) joinStations
{
    NSArray* allValues = [self.stations allValues];
    self.joinedStations = [[NSMutableDictionary alloc] init];
    for (Station* station in allValues)
    {
        NSString* key = [station.stopName stringByReplacingOccurrencesOfString:@" " withString:@""];
//        key = station.stopName
        if([self.joinedStations valueForKey:key] == nil)
        {
            NSMutableArray* list = [[NSMutableArray alloc] init];
            [list addObject:station];
            [self.joinedStations setObject:list forKey:key];
        }
        else
        {
            NSMutableArray* list = [self.joinedStations valueForKey:key];
            [list addObject:station];
        }
    }
}

-(BOOL) checkmatchFrom:(NSString *)string1 to:(NSString*) string2
{
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", string1];
    return ([regex evaluateWithObject:string2] == YES);
}


-(void)parseStopsWithRoutes
{
    NSLog(@"findRoutesForStops");
    NSString* filePath = @"stopsWithRoutes";
    
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
    
    for (int i=0; i<allLinedStrings.count; i++)
    {
        NSString* strsInOneLine = [allLinedStrings objectAtIndex:i];
        
        NSArray* values =
        [strsInOneLine componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@","]];
        
        NSString* stopId = [values objectAtIndex:0];
        int nbRoutes = [[values objectAtIndex:1] intValue];
        
        Station* station = [self.stations objectForKey:stopId];
        station.routes = [NSMutableArray arrayWithCapacity:nbRoutes];
        
        for (int i=2; i<2+nbRoutes; i++)
        {
            Route* route = [RoutesTableViewController getRouteFromId:[values objectAtIndex:i]];
            [station.routes addObject:route];
        }
    }
    
    NSLog(@"end findRoutesForStops");
}



/*
 -(void) joinStations
 {
 NSArray* allValues = [self.stations allValues];
 self.joinedStations = [[NSMutableDictionary alloc] init];
 for (Station* station in allValues)
 {
 NSArray* values =
 [station.stopId componentsSeparatedByCharactersInSet:
 [NSCharacterSet characterSetWithCharactersInString:@"_"]];
 
 NSString* keyId = [values objectAtIndex:0];
 
 if ([keyId isEqualToString:@"CIIDO"])
 {
 NSLog(@"Cité de l'ILL : key = %@",keyId);
 }
 
 if([self.joinedStations valueForKey:keyId] == nil)
 {
 NSMutableArray* list = [[NSMutableArray alloc] init];
 [list addObject:station];
 [self.joinedStations setObject:list forKey:keyId];
 }
 else
 {
 NSMutableArray* list = [self.joinedStations valueForKey:keyId];
 [list addObject:station];
 }
 }
 }*/

@end
