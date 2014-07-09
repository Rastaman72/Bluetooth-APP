//
//  SettingsStudentViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
@interface SettingsStudentViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *spec;
@property (weak, nonatomic) IBOutlet UIPickerView *department;
@property (weak, nonatomic) IBOutlet UIPickerView *year;
@property (weak, nonatomic) IBOutlet UIPickerView *term;
@property (retain, nonatomic)NSArray *departmentArray;
@property (retain, nonatomic)NSArray *yearArray;
@property (retain, nonatomic)NSArray *termArray;
@property (retain, nonatomic)NSArray *specArray;

@property (retain,nonatomic) NSString* selectDepartment;
@property (assign,nonatomic) int selectYear;
@property (assign,nonatomic) int selectTerm;
@property (retain,nonatomic) NSString* selectSpec;
- (IBAction)SaveSChange:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *SaveButton;
@property (nonatomic,retain)NSDictionary* student;

@end
