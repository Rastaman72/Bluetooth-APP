//
//  MainAccessViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"

@interface MainAccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
- (IBAction)LoginPush:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFIeld;

@end
