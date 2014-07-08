//
//  RegisterViewController.h
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *CreateAccountButton;
- (IBAction)CreateAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordField;
@end
