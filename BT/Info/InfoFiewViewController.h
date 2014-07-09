//
//  InfoFiewViewController.h
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
@interface InfoFiewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *SQLButton;
- (IBAction)SQLPush:(id)sender;
@property(nonatomic,retain) NSString* bluetoothID;
@property (nonatomic,retain)NSDictionary* user;
@end
