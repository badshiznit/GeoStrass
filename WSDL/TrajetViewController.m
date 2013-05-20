//
//  TrajetViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 4/8/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "TrajetViewController.h"

@interface TrajetViewController ()

@end

@implementation TrajetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendSoap:(id)sender
{
    ServiceSoapBinding *ctsSoapBinding = [ServiceSvc ServiceSoapBinding];
    ctsSoapBinding.logXMLInOut = YES;
    
    ctsSoapBinding.authUsername = @"amadou.diallo@etu.unistra.fr";
    ctsSoapBinding.authPassword = @"master";
    
    ServiceSvc_rechercheProchainesArriveesWeb* prochainArriveeService = [[ServiceSvc_rechercheProchainesArriveesWeb alloc]init];
    prochainArriveeService.CodeArret = @"527B";
    prochainArriveeService.Mode = [NSNumber numberWithInt:0];
    prochainArriveeService.NbHoraires = [NSNumber numberWithInt:2];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    prochainArriveeService.Heure = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"Date : %@",prochainArriveeService.Heure);
    
    ServiceSvc_CredentialHeader* credentials = [[ServiceSvc_CredentialHeader alloc] init];
    credentials.ID_ = @"43";
    credentials.MDP = @"master";
    
    [ctsSoapBinding rechercheProchainesArriveesWebAsyncUsingParameters:prochainArriveeService CredentialHeader:credentials CredentialHeader:credentials delegate:self];
}

-(void) operation:(ServiceSoapBindingOperation *)operation completedWithResponse:(ServiceSoapBindingResponse *)response
{
    NSLog(@"Operation = %@, response = %@",operation.description,response.description);
    
    for (id rep in response.headers)
    {
        NSLog(@"Header = %@",rep);
    }
    
    NSLog(@"Error = %@",response.error.description);
    
    for (id rep in response.bodyParts)
    {
        NSLog(@"BodyPart = %@",rep);
        ServiceSvc_rechercheProchainesArriveesWebResponse* response = (ServiceSvc_rechercheProchainesArriveesWebResponse*)rep;
        if([response isKindOfClass:[ServiceSvc_rechercheProchainesArriveesWebResponse class]])
        {
            NSLog(@"NbProchains arrivee = %d",response.rechercheProchainesArriveesWebResult.ListeArrivee.Arrivee.count);
            
            for (id arr in response.rechercheProchainesArriveesWebResult.ListeArrivee.Arrivee)
            {
                ServiceSvc_Arrivee* arrivee = (ServiceSvc_Arrivee*)arr;
                NSLog(@"Destination = %@, heure = %@, Mode = %@",arrivee.Destination,arrivee.Horaire,arrivee.Mode);

            }
        }
    }
}

@end
