//
//  MainAccessViewController.h
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
//#import "MainViewController.h"


@protocol LoginDelegate <NSObject>
-(void) loginSucced:(NSDictionary *)dataForMainView;
@end

@interface MainAccessViewController : UIViewController
{
    __weak id loginDelegate;
}

@property (nonatomic, weak) id<LoginDelegate> loginDelegate;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
- (IBAction)LoginPush:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFIeld;
@property (nonatomic,retain) NSDictionary *responseDict ;

@end
