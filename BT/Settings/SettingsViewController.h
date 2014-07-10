//
//  SettingsViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"SettingsStudentViewController.h"
#import "SettingsStudentViewController.h"
#import "SettingsTeacherViewController.h"
#import "MainViewController.h"
@interface SettingsViewController : UIViewController<LoginDelegate>
@property(nonatomic,retain)NSDictionary* userData;
@end
