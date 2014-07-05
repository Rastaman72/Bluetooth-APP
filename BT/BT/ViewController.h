//
//  ViewController.h
//  BT
//
//  Created by LGBS dev on 7/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>


#import "SERVICES.h"
@interface ViewController : UIViewController

- (IBAction)touched:(id)sender;

@property (nonatomic,strong) NSMutableData *data;


@end

