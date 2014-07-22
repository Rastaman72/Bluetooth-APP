//
//  MainViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainAccessViewController.h"
#import "BTViewControllerTableViewController.h"
#import "SettingsViewController.h"
#import "MapViewController.h"
#import "Localization.h"

@interface MainViewController : UIViewController <UIAlertViewDelegate,LoginDelegate>
- (IBAction)logOut:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
@property(nonatomic,retain)NSDictionary* user;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
- (IBAction)mapPush:(id)sender;
@property(nonatomic,assign)bool updateData;
@property(nonatomic,retain) NSString *UUID;
@property(nonatomic,retain)NSDictionary* place;
@property(nonatomic,retain)NSMutableArray* localizationArray;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,retain)CLLocation *lastLocation;
@end
