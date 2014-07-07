//
//  SettingsTeacherViewController.h
//  BT
//
//  Created by LGBS dev on 7/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
@interface SettingsTeacherViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *department;
@property (weak, nonatomic) IBOutlet UIPickerView *subject;

@property (retain, nonatomic)NSArray *departmentArray;
@property (retain, nonatomic)NSArray *subjectArray;

@property (retain,nonatomic) NSString* selectDepartment;
@property (retain,nonatomic) NSString* selectSebject;
@property (weak, nonatomic) IBOutlet UIButton *SaveTButton;
- (IBAction)SaveChange:(id)sender;


@end
