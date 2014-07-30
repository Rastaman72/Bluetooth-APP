//
//  MapRootTableViewController.m
//  BT
//
//  Created by LGBS dev on 7/29/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MapRootTableViewController.h"

@interface MapRootTableViewController ()

@end

@implementation MapRootTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
       // self.users = [[NSMutableArray alloc]init];
        //[self.users addObject:[StudentAccount newStudent:@"Intro"]];
    }
     return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self startMonitoringGPS];
    
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
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* student=[self.users objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Student" forIndexPath:indexPath];
    cell.textLabel.text=[[student objectForKey:@"Login"]description];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *student=[self.users objectAtIndex:indexPath.row];
    if(self.delegate.sendFree)
    {
        NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
         NSString *UUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
           ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request setPostValue:@"getHistory" forKey:@"TYPE"];
            [request setPostValue:UUID forKey:@"UUID"];
             [request setPostValue:[[student objectForKey:@"Login"]description ]forKey:@"UserID"];
            [request setDelegate:self];
            [request startAsynchronous];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"Updating...";
            self.navigationItem.hidesBackButton = YES;
    }

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    self.delegate.sendFree=true;
    if (request.responseStatusCode == 400) {
        // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        //  _result.text = @"Code already used";
    } else if (request.responseStatusCode == 210) {
        self.historicalLocalization=[[NSMutableArray alloc]init];
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);        
        NSData* data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError*error;
        _place=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        for (id onePlace in _place) {
            Localization* singlePlace=[Localization initLocalizationWithID:[[onePlace valueForKey:@"Device"]description] andTime:[[onePlace valueForKey:@"Time"]description ] andGpsLong:[[onePlace valueForKey:@"GPSLong"]description] andGpsLati:[[onePlace valueForKey:@"GPSLati"]description] andBeacon:[[onePlace valueForKey:@"Place"]description] andUser:[[onePlace valueForKey:@"UserID"]description ] ];
            [self.historicalLocalization addObject:singlePlace];
            
        }
        [self performSegueWithIdentifier:@"ListToMap" sender:self];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }else {
        //_result.text = @"Unexpected error";
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.navigationItem.hidesBackButton = NO;
        
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    self.delegate.sendFree=true;
    NSError *error = [request error];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.navigationItem.hidesBackButton = NO;
    // _result.text = error.localizedDescription;
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
    if ([segue.identifier isEqualToString:@"ListToMap"]) {
    MapViewController *MVC = (MapViewController *)segue.destinationViewController;
    MVC.lastLocation=[self location];
    MVC.localizationArray =[[NSMutableArray alloc]init];
    [MVC.localizationArray addObjectsFromArray:_historicalLocalization];
    }

}



- (void)startMonitoringGPS
{
    [self setLocationManager:[[CLLocationManager alloc] init]];
	[_locationManager setDelegate:self];
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[_locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *lastLocation = [locations lastObject];
    self.location=lastLocation;
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    
   	
}


@end
