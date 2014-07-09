//
//  MainViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainAccessViewController.h"
#import "BTViewControllerTableViewController.h"
#import "SettingsViewController.h"

@interface ProperViewSegue : UIStoryboardSegue
@end
@interface MainViewController : UIViewController <LoginDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
@property(nonatomic,retain)NSDictionary* user;
@end
