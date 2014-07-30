//
//  MainViewController.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MainViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CoreLocation/CoreLocation.h>
@interface MainViewController ()

@end

@implementation MainViewController
{
    dispatch_queue_t backgroundQueue;
}



-(void)viewWillAppear:(BOOL)animated
{
    [self setLocationManager:[[CLLocationManager alloc] init]];
	[_locationManager setDelegate:self];
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[_locationManager startUpdatingLocation];
      self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	
	_lastLocation = [locations lastObject];
    CLLocationAccuracy accuracy = [_lastLocation horizontalAccuracy];
	NSLog(@"Received location %@ with accuracy %f", _lastLocation, accuracy);
    [manager stopUpdatingLocation];
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        [self performSegueWithIdentifier:@"MainToSettings" sender:self];
        _updateData=YES;
        
    }
}

-(void)spy{
    _localSpy=[[Spy alloc]initWithUser:_user];
    _localSpy.process;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if(_updateData)
    {
        [self getNewData];
        _updateData=false;
    }
    else
    {
        if (_user)
        {
#warning SYFF
#warning SYFF
#warning SYFF
            NSString* test =[[NSString alloc]initWithString:[[_user valueForKey:@"Department"]description]];
            test = [test stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
            test = [test stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
            test = [test stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            self.spyTimer = [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(spy) userInfo:nil repeats: YES];
            
            if([test isEqualToString:@"\"\""])
            {
                
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                     message:@"You have empty detail\n Do you want fill it right now?"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Fill it"
                                                           otherButtonTitles:@"Back",nil];
                errorAlert.show;
                
            }
        }
        
    }
    
}

-(void)getNewData
{
    if(self.delegate.sendFree)
    {
         self.delegate.sendFree=false;
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    
    NSString* userLogin =[[NSString alloc]initWithString:[[_user valueForKey:@"Login"]description]];
    userLogin = [userLogin stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
    userLogin = [userLogin stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
    userLogin = [userLogin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"getNewDataS" forKey:@"TYPE"];
    [request setPostValue:userLogin forKey:@"Login"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating...";
    self.navigationItem.hidesBackButton = YES;
    }
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
      self.delegate.sendFree=true;
    if (request.responseStatusCode == 400) {
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);
        
    } else if (request.responseStatusCode == 403) {
        
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);
        NSData* data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError*error;
        _user=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }
    
   /* else if (request.responseStatusCode == 210) {
        _localizationArray=[[NSMutableArray alloc]init];
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);
        NSArray *listItems = [responseString componentsSeparatedByString:@","];
        
        NSData* data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError*error;
        _place=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        for (id onePlace in _place) {
            Localization* singlePlace=[Localization initLocalizationWithID:[[onePlace valueForKey:@"Device"]description] andTime:[[onePlace valueForKey:@"Time"]description ] andGpsLong:[[onePlace valueForKey:@"GPSLong"]description] andGpsLati:[[onePlace valueForKey:@"GPSLati"]description] andBeacon:[[onePlace valueForKey:@"Place"]description] andUser:[[onePlace valueForKey:@"UserID"]description ] ];
            [_localizationArray addObject:singlePlace];
            
        }
        [self performSegueWithIdentifier:@"MainToMap" sender:self];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }*/
    else if (request.responseStatusCode == 215) {
        self.userList=[[NSMutableDictionary alloc]init];
        NSString *responseString = [request responseString];
        NSData* data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error;
        self.userList=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        [self performSegueWithIdentifier:@"MainToMap" sender:self];
    }
    else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.navigationItem.hidesBackButton = NO;
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
      self.delegate.sendFree=true;
    NSError *error = [request error];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.navigationItem.hidesBackButton = NO;
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:[error localizedDescription]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    errorAlert.show;
    
    
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _UUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    [self performSegueWithIdentifier:@"MainToLogin" sender:self];
    self.navigationItem.hidesBackButton = YES;
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginSucced:(NSDictionary *)dictForMain
{
    _user=dictForMain;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainToLogin"]) {
        MainAccessViewController *MAVC = (MainAccessViewController *)segue.destinationViewController;
        MAVC.loginDelegate = self;
    }
    
    
    if ([segue.identifier isEqualToString:@"MainToBTList"]) {
        BTViewControllerTableViewController *BTVCTVC = (BTViewControllerTableViewController *)segue.destinationViewController;
        BTVCTVC.user = _user;
    }
    
    if ([segue.identifier isEqualToString:@"MainToSettings"]) {
        SettingsViewController *SVC = (SettingsViewController*)segue.destinationViewController;
        SVC.userData = _user;
    }
    
    if ([segue.identifier isEqualToString:@"MainToMap"]) {
        MapRootTableViewController *MRTVC = (MapRootTableViewController*)segue.destinationViewController;
        MRTVC.historicalLocalization=[[NSMutableArray alloc]init];
        [MRTVC.historicalLocalization addObjectsFromArray:(NSArray*)_localizationArray];
        MRTVC.users=[[NSMutableArray alloc]init];
        [MRTVC.users addObjectsFromArray:self.userList];
    }
}

- (IBAction)logOut:(id)sender {
    
    [self performSegueWithIdentifier:@"MainToLogin" sender:self];
    
}



- (IBAction)mapPush:(id)sender {
    if(self.delegate.sendFree)
    {
         self.delegate.sendFree=false;
//    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setPostValue:@"getHistory" forKey:@"TYPE"];
//    [request setPostValue:_UUID forKey:@"UUID"];
//    [request setDelegate:self];
//    [request startAsynchronous];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"Updating...";
//    self.navigationItem.hidesBackButton = YES;
        
        NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:@"getUserList" forKey:@"TYPE"];
        [request setDelegate:self];
        [request startAsynchronous];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Updating...";
        self.navigationItem.hidesBackButton = YES;
    }
    
}
@end
