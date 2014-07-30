//
//  VerifyTeacherViewController.h
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
@interface VerifyTeacherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *VerifyField;
@property (weak, nonatomic) IBOutlet UIButton *VerifyButton;
- (IBAction)Verify:(id)sender;
@property (nonatomic,strong)    AppDelegate *delegate ;
@end
