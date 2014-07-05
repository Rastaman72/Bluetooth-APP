//
//  BTViewControllerTableViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SERVICES.h"
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"
@interface BTViewControllerTableViewController : UITableViewController<ESTBeaconManagerDelegate>

@property (nonatomic, strong) NSMutableArray *btBeacon;
@property (nonatomic,strong) CBCentralManager * centralManager;
@property (nonatomic,strong) CBPeripheral * discoveredPeripheral;
@property (nonatomic,strong) NSMutableData *data;
@property (nonatomic,retain) ESTBeaconManager* beaconManager;
@property (nonatomic,retain) ESTBeaconRegion* beaconRegion;
@property (nonatomic,retain) ESTBeacon* beacon;

@end
