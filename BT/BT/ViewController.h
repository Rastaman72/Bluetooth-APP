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
@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralManagerDelegate,UITextFieldDelegate>

- (IBAction)touched:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *sqlbutton;
@property (strong, nonatomic) IBOutlet UITextView *textview;
@property (nonatomic,strong) CBCentralManager * centralManager;
@property (nonatomic,strong) CBPeripheral * discoveredPeripheral;
@property (weak, nonatomic) IBOutlet UITextView *result;
@property (weak, nonatomic) IBOutlet UITextField *request;
@property (nonatomic,strong) NSMutableData *data;
@property (nonatomic,assign)BOOL foundAulaB;
@end

