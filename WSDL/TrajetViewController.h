//
//  TrajetViewController.h
//  GeoStrass
//
//  Created by amadou diallo on 4/8/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceSvc.h"

@interface TrajetViewController : UIViewController<ServiceSoapBindingResponseDelegate>

@property (strong, nonatomic) IBOutlet UIButton *send;
- (IBAction)sendSoap:(id)sender;

@end
