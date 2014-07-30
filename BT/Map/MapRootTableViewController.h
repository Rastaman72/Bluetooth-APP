//
//  MapRootTableViewController.h
//  BT
//
//  Created by LGBS dev on 7/29/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MapRootTableViewController : UITableViewController
@property(nonatomic,retain) NSMutableArray* users;
@property(nonatomic,retain)CLLocation *location;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic,retain)NSMutableArray* historicalLocalization;
@end
