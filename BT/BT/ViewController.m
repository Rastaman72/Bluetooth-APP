//
//  ViewController.m
//  BT
//
//  Created by LGBS dev on 7/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _centralManager =[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    _data=[[NSMutableData alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [_centralManager stopScan];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if(central.state != CBCentralManagerStatePoweredOn)
    {
        return;
    }
    
    if (central.state == CBCentralManagerStatePoweredOn) {
        [_centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
        // NSLog(@"scanning started");
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    // NSLog(@"Discovered %@ at %@",peripheral.name,RSSI);
    if(_discoveredPeripheral != peripheral)
    {
        _discoveredPeripheral=peripheral;
        //NSLog(_discoveredPeripheral.name);
        //NSLog(@"Connecting to peripherail %@",peripheral);
        [_centralManager connectPeripheral:peripheral options:nil];
    }
}

-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"AIL");
    [self cleanup];
}

-(void) cleanup
{
    if (_discoveredPeripheral.services != nil) {
        for (CBService *service in _discoveredPeripheral.services){
            if(service.characteristics != nil) {
                for(CBCharacteristic *chracteristic in service.characteristics) {
                    if([chracteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]){
                        if(chracteristic.isNotifying){
                            [_discoveredPeripheral setNotifyValue:NO forCharacteristic:chracteristic];
                            return;
                        }
                    }
                }
            }
        }
    }
    
    [_centralManager cancelPeripheralConnection:_discoveredPeripheral];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    // NSLog(@"Connected");
    
    [_centralManager stopScan];
    //NSLog(@"Scanning stopped");
    
    [_data setLength:0];
    
    peripheral.delegate = self;
    
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        [self cleanup];
        return;
    }
    
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
    }
    // Discover other characteristics
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        [self cleanup];
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error");
        return;
    }
    
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    if ([stringFromData isEqualToString:@"EOM"]) {
        
        [_textview setText:[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]];
        
        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        
        [_centralManager cancelPeripheralConnection:peripheral];
    }
    
    [_data appendData:characteristic.value];
    NSString *receivedDataString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",receivedDataString);
    
    NSString *lookingWord = @"AulaB";
    
    
    _sqlbutton.enabled=TRUE;
    [_sqlbutton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    NSLog(@"%i",_sqlbutton.enabled);
    if([receivedDataString rangeOfString:lookingWord].location != NSNotFound)
    {
        NSLog(@"founded");
        _foundAulaB=TRUE;
        
        _sqlbutton.enabled=YES;
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    if (characteristic.isNotifying) {
        NSLog(@"Notification began on %@", characteristic);
    } else {
        // Notification has stopped
        [_centralManager cancelPeripheralConnection:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    _discoveredPeripheral = nil;
    
    [_centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
}


- (IBAction)touched:(id)sender {
    NSString* code;
    _foundAulaB=YES;
    if(_foundAulaB)
    {
        code=@"1";
        NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:code forKey:@"ID"];
        [request setDelegate:self];
        [request startAsynchronous];
        
        // Hide keyword
        
        // Clear text field
        _result.text = @"";
        
    }
    
    
    
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.responseStatusCode == 400) {
        _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        _result.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        
        NSString *forJSON=[[NSString alloc] init];
        
        NSRange startRange = [responseString rangeOfString:@"Array{"];
        NSRange endRange = [responseString rangeOfString:@"\"}"];
        
        NSRange searchRange = NSMakeRange(startRange.location , endRange.location-startRange.location );
        [responseString substringWithRange:searchRange];
        
        NSLog(@"%@",responseString);
        NSLog(@"%@",forJSON);
        
        NSDictionary *responseDict = [forJSON JSONValue];
        
        _result.text = responseString;
        
        
    } else {
        _result.text = @"Unexpected error";
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    _result.text = error.localizedDescription;
}




@end
