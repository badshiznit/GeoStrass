//
//  Tram+BusStations.m
//  GeoStrass
//
//  Created by amadou diallo on 2/1/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "Tram+BusStations.h"

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
}

@end
