//
//  AroundMeMasterCell.h
//  GeoStrass
//
//  Created by amadou diallo on 3/4/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperStation.h"
#import "Route.h"

@class AroundMeMasterCell;

@protocol AroundMeMasterCellDelegate <NSObject>

@required

-(void) didSelectRouteAtCell:(AroundMeMasterCell*) aroundMeMasterCell;

@end

@interface AroundMeMasterCell : UITableViewCell

@property(nonatomic,strong) id<AroundMeMasterCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *firstImageV;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *routesView;
@property(nonatomic,strong) SuperStation* masterStation;
@property(nonatomic,strong) Route* selectedRoute;

-(void) setMasterStation:(SuperStation *)masterStation withScope:(NSInteger)scope;

@end
