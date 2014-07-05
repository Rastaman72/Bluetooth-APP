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

@interface BTViewControllerTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableData *data;


@end
