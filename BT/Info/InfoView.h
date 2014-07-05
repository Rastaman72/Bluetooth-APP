//
//  InfoView.h
//  BT
//
//  Created by LGBS dev on 7/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@interface InfoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *SQLButton;
- (IBAction)SQLPush:(id)sender;

@end
