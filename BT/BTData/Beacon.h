//
//  Beacon.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"
@interface Beacon : NSObject<ESTBeaconManagerDelegate>


@property (nonatomic, strong) NSMutableArray *btBeacon;

@property (nonatomic,retain) ESTBeaconManager* beaconManager;
@property (nonatomic,retain) ESTBeaconRegion* beaconRegion;
@property (nonatomic,retain) ESTBeacon* beacon;
@end
