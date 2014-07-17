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
#import "Connection.h"

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
- (IBAction)backPush:(id)sender;

@property(nonatomic,retain)NSDictionary* userData;

//teacher
@property (weak, nonatomic) IBOutlet UIButton *teacherButton;
- (IBAction)teacherPush:(id)sender;
@property (nonatomic,retain)NSMutableDictionary  * tempDepa;
@property (nonatomic,retain)NSMutableDictionary  * tempInst;

@property(nonatomic,retain)NSMutableArray* tempDepaArray;
@property(nonatomic,retain)NSMutableArray* tempInstArray;



//student
@property (weak, nonatomic) IBOutlet UIButton *studentButton;
- (IBAction)studentPush:(id)sender;
@property (nonatomic,retain)NSMutableDictionary  * tempDepartment;
@property (nonatomic,retain)NSMutableDictionary  * tempYear;
@property (nonatomic,retain)NSMutableDictionary  * tempTerm;
@property (nonatomic,retain)NSMutableDictionary  * tempSpec;


@property(nonatomic,retain)NSMutableArray*tempDepartmentArray;
@property(nonatomic,retain)NSMutableArray*tempYearArray;
@property(nonatomic,retain)NSMutableArray*tempTermArray;
@property(nonatomic,retain)NSMutableArray*tempSpecArray;
@end
