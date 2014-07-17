//
//  InfoFiewViewController.m
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "InfoFiewViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CoreLocation/CoreLocation.h>
@interface InfoFiewViewController ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation InfoFiewViewController

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
    [self setLocationManager:[[CLLocationManager alloc] init]];
	[_locationManager setDelegate:self];
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[_locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	//1
	CLLocation *lastLocation = [locations lastObject];
    _gpsLongitude=lastLocation.coordinate.longitude;
	_gpsLatitude=lastLocation.coordinate.latitude;//2
    _timeMark=lastLocation.timestamp;
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    
	//3
		[manager stopUpdatingLocation];
	
}

- (IBAction)SQLPush:(id)sender {
    NSString* code;
   code=_bluetoothID;

   
    NSString *UUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    NSNumber* gpsLongitude=[[NSNumber alloc]initWithFloat:_gpsLongitude];
    NSNumber* gpsLatitude=[[NSNumber alloc]initWithFloat:_gpsLatitude ];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"deviceInfo" forKey:@"TYPE"];
    [request setPostValue:UUID forKey:@"UUID"];
    [request setPostValue:gpsLongitude forKey:@"gpsLong"];
    [request setPostValue:gpsLatitude forKey:@"gpsLati"];
    [request setPostValue:_timeMark forKey:@"time"];
    [request setPostValue:_bluetoothID forKey:@"place"];
 
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Fetching data";
    self.navigationItem.hidesBackButton = YES;
    // Hide keyword
    
    // Clear text field
    
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.responseStatusCode == 400) {
        // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        //  _result.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        
//        
//        NSRange startRange = [responseString rangeOfString:@"Array{"];
//        NSRange endRange = [responseString rangeOfString:@"\"}"];
//        
//        NSRange searchRange = NSMakeRange(startRange.location+5 , endRange.location-startRange.location+-3 );
//        NSString* forJSON=[[NSString alloc]initWithString:[responseString substringWithRange:searchRange]];
//        
        NSLog(@"%@",responseString);
//        NSLog(@"%@",forJSON);
//        
//        NSDictionary *responseDict = [forJSON JSONValue];
//        
        // _result.text = responseString;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.navigationItem.hidesBackButton = NO;
        
    } else {
        //_result.text = @"Unexpected error";
        [MBProgressHUD hideHUDForView:self.view animated:YES];
          self.navigationItem.hidesBackButton = NO;

    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
      self.navigationItem.hidesBackButton = NO;
    // _result.text = error.localizedDescription;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
