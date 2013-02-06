//
//  PersoTabBarController.h
//  GeoStrass
//
//  Created by amadou diallo on 1/24/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersoTabBarController : UITabBarController

@property(nonatomic,strong) UIButton* aroundMeButton;

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;


@end
