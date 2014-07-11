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
@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *teacherButton;
@property(nonatomic,retain)NSDictionary* userData;
@property (weak, nonatomic) IBOutlet UIButton *studentButton;
@end
