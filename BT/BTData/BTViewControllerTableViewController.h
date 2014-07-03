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

@interface BTViewControllerTableViewController : UITableViewController<CBCentralManagerDelegate,CBPeripheralManagerDelegate>

@property (nonatomic, strong) NSMutableArray *btBeacon;
@property (nonatomic,strong) CBCentralManager * centralManager;
@property (nonatomic,strong) CBPeripheral * discoveredPeripheral;
@property (nonatomic,strong) NSMutableData *data;
@end
