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
#import <dispatch/dispatch.h>
#import "Spy.h"
#import "MapRootTableViewController.h"
@interface MainViewController : UIViewController <UIAlertViewDelegate,LoginDelegate>
- (IBAction)logOut:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
@property(nonatomic,retain)NSDictionary* user;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
- (IBAction)mapPush:(id)sender;
@property(nonatomic,assign)bool updateData;
@property(nonatomic,retain) NSString *UUID;

@property(nonatomic,retain)NSMutableArray* localizationArray;
@property(nonatomic,retain)NSMutableDictionary* userList;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,retain)CLLocation *lastLocation;
@property(nonatomic,strong)Spy* localSpy;
@property(nonatomic,strong)NSTimer *spyTimer;
@property (nonatomic,strong)    AppDelegate *delegate ;
@end
