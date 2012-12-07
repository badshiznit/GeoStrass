//
//  StationVeloCell.h
//  GeoStrass
//
//  Created by amadou diallo on 12/5/12.
//  Copyright (c) 2012 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationVelhop.h"

@interface StationVeloCell : UITableViewCell

@property (strong,nonatomic) StationVelhop* station;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cbImageView;
@property (nonatomic, assign) CLLocationDistance distanceFromUser;

-(void) fillCellWithstation:(StationVelhop*) station;
-(void)computeDistanceFromLocation:(CLLocation*) coordinate;

@end
