//
//  BTViewControllerTableViewController.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "BTViewControllerTableViewController.h"
#import"Beacon.h"
#import "BTCellTableViewCell.h"

@interface BTViewControllerTableViewController ()

@end

@implementation BTViewControllerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    
    return self;
}

- (void)viewDidLoad
{
    //
    //    NSMutableArray* _btBeacons;
    //
    //    _btBeacons=[[NSMutableArray alloc]initWithCapacity:10];
    //    Beacon* bt1=[[Beacon alloc]init];
    //    bt1.name=@"BT!";
    //    bt1.Function=@"AulaB";
    //    bt1.ID=1;
    //    [_btBeacons addObject:bt1];
    //
    //    Beacon* bt2=[[Beacon alloc]init];
    //    bt2.name=@"BT2";
    //    bt2.Function=@"AulaC";
    //    bt2.ID=2;
    //    [_btBeacons addObject:bt2];
    //
    //
    //    self.btBeacon=_btBeacons;
    
    
    [super viewDidLoad];
    _data=[[NSMutableData alloc] init];
    
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BTCellTableViewCell *cell=(BTCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"BTCell"];
    
    
    //dopisać pobieranie z obiektu beacon zamiast zl sity
    
//    ESTBeacon* beacon=(self.btBeacon)[indexPath.row];
//    
//    NSString* name=[NSString stringWithFormat:@"%d",beacon.color];
//    NSString* function=[NSString stringWithFormat:@"%@",beacon.major];
//    
//    cell.nameLabel.text=name;
//    cell.functionLabel.text=function;
//    cell.distanceImageView=nil;
//    return cell;
}




- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}



/*
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
 
 // [_textview setText:[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]];
 
 [peripheral setNotifyValue:NO forCharacteristic:characteristic];
 
 [_centralManager cancelPeripheralConnection:peripheral];
 }
 
 [_data appendData:characteristic.value];
 NSString *receivedDataString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
 NSLog(@"%@",receivedDataString);
 
 //    NSString *lookingWord = @"AulaB";
 //
 //
 //    _sqlbutton.enabled=TRUE;
 //    [_sqlbutton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
 //    NSLog(@"%i",_sqlbutton.enabled);
 //    if([receivedDataString rangeOfString:lookingWord].location != NSNotFound)
 //    {
 //        NSLog(@"founded");
 //        _foundAulaB=TRUE;
 //
 //        _sqlbutton.enabled=YES;
 //    }
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
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
