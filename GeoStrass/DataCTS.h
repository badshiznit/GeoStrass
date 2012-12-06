//
//  DataCTS.h
//  GeoStrass
//
//  Created by amadou diallo on 12/5/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataCTSDelegate <NSObject>

@required
- (void) didFinishedLoadingData: (NSArray*)stations;
@end


@interface DataCTS : NSObject<NSXMLParserDelegate>

@property(nonatomic,strong) id<DataCTSDelegate> delegate;

@property(nonatomic,strong) NSURL* url;
@property(nonatomic,strong) NSMutableData* receivedData;
@property(nonatomic,strong) NSMutableArray* stations;
@property(nonatomic,strong) NSMutableDictionary* stationsDict;

-(id) initWithUrl:(NSString*) aUrl;
-(void) loadData;

@end
