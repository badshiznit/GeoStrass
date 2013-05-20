//
//  DataCTS.m
//  GeoStrass
//
//  Created by amadou diallo on 12/5/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import "DataCTS.h"
#import "StationVelhop.h"

@implementation DataCTS


-(id) initWithUrl:(NSString*) aUrl
{
    self = [super init];
    if(self)
    {
        self.url = [NSURL URLWithString:aUrl];
    }
    return self;        
}

-(void) loadData
{
    NSURLRequest* req = [[NSURLRequest alloc] initWithURL:self.url];
    
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    
    if (conn)
    {
        self.receivedData = [NSMutableData data] ;
    } else {
        NSLog(@"Connection failed");
    }

    [conn start];
}


-(void)connection :(NSURLConnection *) connection didReceiveData:(NSData *)data
{
   [self.receivedData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   
    NSLog(@"didReceiveResponse");
    [self.receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@",
    [error localizedDescription],
    [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[self.receivedData length]);

    NSString* response = [[NSString alloc] initWithData:self.receivedData encoding:NSASCIIStringEncoding];
    NSLog(@"Data : %@",response);
    [self parseVelosData:self.receivedData];
}


#pragma mark Parsing XML


- (void)parseVelosData:(NSData *)data
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    self.stations = [[NSMutableArray alloc] init]; // Create our scheduler list
    self.stationsDict = [[NSMutableDictionary alloc] init];
    [parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; //
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
    
    [parser parse]; // Parse that data..
    
    [self.delegate didFinishedLoadingData:self.stationsDict.allValues];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Element Name : %@",elementName);
    
    NSString* sid,*na,*la,*lg,*av,*fr,*to,*cb;
    
    CLLocationCoordinate2D coord;
    
    StationVelhop* station;
   
    if([elementName isEqualToString:@"si"])
    {
       // NSLog(@"%@",attributeDict.description);
        
        sid =[attributeDict objectForKey:@"id"];
        na = [attributeDict objectForKey:@"na"];
        la = [attributeDict objectForKey:@"la"];
        lg = [attributeDict objectForKey:@"lg"];
        av = [attributeDict objectForKey:@"av"];
        to = [attributeDict objectForKey:@"to"];
        fr = [attributeDict objectForKey:@"fr"];
        cb = [attributeDict objectForKey:@"cb"];
        
        coord = CLLocationCoordinate2DMake([la doubleValue], [lg doubleValue]);
        
        BOOL hasCB = (cb)? YES : NO;
        
        station = [[StationVelhop alloc] initWithId:sid name:na
                                         coordinate:coord
                                   nbAvailableBikes:[av integerValue]
                                        nbUsedBikes:[fr integerValue]
                                       nbTotalBikes:[to integerValue]
                                           andHasCB:hasCB];
    }
    
    if(station)
    {
        NSLog(@"station : %@ ajoutée", station.name);
        
        if([self.stationsDict objectForKey:station.sid])
        {
            StationVelhop* oldStation = [self.stationsDict objectForKey:station.sid];
            oldStation.nbTotal += station.nbTotal;
            oldStation.nbAvailable += station.nbAvailable;
            oldStation.nbUsed += station.nbUsed;
            oldStation.hasCB = (station.hasCB)? station.hasCB : oldStation.hasCB;
        }
            else
                [self.stationsDict setObject:station forKey:station.sid];
    }   
}

@end
