//
//  RegisterViewController.h
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
@interface RegisterViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *CreateAccountButton;
- (IBAction)CreateAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIPickerView *accountType;
@property (retain, nonatomic)NSArray *accountTypeArray;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)backPush:(id)sender;

@property (retain,nonatomic) NSString* selectAccountType;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordField;

@end
