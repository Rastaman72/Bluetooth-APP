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
    self.btBeacon =[[NSMutableArray alloc]init];
    
    
    
    self.beaconManager = [[ESTBeaconManager alloc]init];
    self.beaconManager.delegate=self;
    self.beaconManager.avoidUnknownStateBeacons=YES;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                                 major:[self.beacon.major unsignedIntValue]
                                                                 minor:[self.beacon.minor unsignedIntValue]
                                                            identifier:@"RegionIdentifier"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
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
    return [self.btBeacon count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BTCellTableViewCell *cell=(BTCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"BTCell"];
    ESTBeacon* beacon=(self.btBeacon)[indexPath.row];
    
    NSString* name=[NSString stringWithFormat:@"%d",beacon.color];
    NSString* function=[NSString stringWithFormat:@"%@",beacon.major];
    NSString* distance=[NSString stringWithFormat:@"%@",beacon.distance];
    
    cell.nameLabel.text=name;
    cell.functionLabel.text=function;
    cell.distanceLabel.text=distance;
    cell.distanceImageView=nil;
    return cell;
}




- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}


- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.btBeacon = beacons;
    
    [self.tableView reloadData];
   
}


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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"ListToInfo"]){
         InfoFiewViewController *controller = (InfoFiewViewController *)segue.destinationViewController;
         controller.bluetoothID = [[sender nameLabel]text];
     }
 }


@end
