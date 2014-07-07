//
//  InfoFiewViewController.h
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
@interface InfoFiewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *SQLButton;
- (IBAction)SQLPush:(id)sender;
@end
