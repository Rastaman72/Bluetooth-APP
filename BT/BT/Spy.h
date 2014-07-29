//
//  Spy.h
//  BT
//
//  Created by LGBS dev on 7/29/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CoreLocation/CoreLocation.h>
#import "Connection.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"
#import <dispatch/dispatch.h>

@interface Spy : NSObject<ESTBeaconManagerDelegate>

@property(nonatomic,retain) NSString* bluetoothID;
@property (nonatomic,retain)NSDictionary* user;
@property (nonatomic,assign)float gpsLongitude;
@property  (nonatomic,assign)float gpsLatitude;
@property  (nonatomic,assign)double timeMark;
@property (nonatomic, strong) CLLocationManager *locationManager;
-(void)sendData;
-(Spy*)initWithUser:(NSDictionary*)user;
@property (nonatomic, strong) NSMutableArray *btBeacon;

@property (nonatomic,retain) ESTBeaconManager* beaconManager;
@property (nonatomic,retain) ESTBeaconRegion* beaconRegion;
@property (nonatomic,retain) ESTBeacon* beacon;

@end
