//
//  studentSettingsViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StudentSettingsViewController;

@protocol StudentSettingsViewControllerDelegate <NSObject>
- (void)studentSettingsViewControllerDidBack:(StudentSettingsViewController *)controller;

@end
@interface StudentSettingsViewController : UINavigationController
@property (nonatomic, weak) id <StudentSettingsViewControllerDelegate> delegate;

- (IBAction)back:(id)sender;
@end
