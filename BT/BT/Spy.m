//
//  Spy.m
//  BT
//
//  Created by LGBS dev on 7/29/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "Spy.h"

@implementation Spy
{
dispatch_queue_t backgroundQueue;
}

-(Spy*)initWithUser:(NSDictionary*)user 
{
    Spy* newSpy=[[Spy alloc]init];
    if(newSpy)
    {
        newSpy.user=user;
    }
    
    backgroundQueue = dispatch_queue_create("SpyBack", NULL);
    [self process];

    return newSpy;
}

- (void)process {
    dispatch_async(backgroundQueue, ^(void) {
        
        [self startMonitoringGPS];
        
    });
}

- (void)startMonitoringGPS
{
        [self setLocationManager:[[CLLocationManager alloc] init]];
	[_locationManager setDelegate:self];
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[_locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	CLLocation *lastLocation = [locations lastObject];
    _gpsLongitude=lastLocation.coordinate.longitude;
	_gpsLatitude=lastLocation.coordinate.latitude;
    
    _timeMark=[lastLocation.timestamp timeIntervalSince1970];
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    
    [manager stopUpdatingLocation];
  [self startMonitoringBT];
	
}

-(void)startMonitoringBT
{
    self.beaconManager = [[ESTBeaconManager alloc]init];
    self.beaconManager.delegate=self;
    self.beaconManager.avoidUnknownStateBeacons=YES;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                                 major:[self.beacon.major unsignedIntValue]
                                                                 minor:[self.beacon.minor unsignedIntValue]
                                                            identifier:@"RegionIdentifier"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}


- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.btBeacon = beacons;
    _bluetoothID=@"MEGATEST";
      [self sendData];

}

-(void)sendData
{
    
    NSString *UUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    NSNumber* gpsLongitude=[[NSNumber alloc]initWithFloat:_gpsLongitude];
    NSNumber* gpsLatitude=[[NSNumber alloc]initWithFloat:_gpsLatitude ];
    NSNumber* timeMark=[[NSNumber alloc]initWithDouble:_timeMark ];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"deviceInfo" forKey:@"TYPE"];
    [request setPostValue:UUID forKey:@"UUID"];
    [request setPostValue:gpsLongitude forKey:@"gpsLong"];
    [request setPostValue:gpsLatitude forKey:@"gpsLati"];
    [request setPostValue:timeMark forKey:@"time"];
    [request setPostValue:_bluetoothID forKey:@"place"];
    
    NSString* userID =[[NSString alloc]initWithString:[[_user valueForKey:@"Login"]description]];
    userID = [userID stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
    userID = [userID stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
    userID = [userID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [request setPostValue:userID forKey:@"userID"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
}
@end
