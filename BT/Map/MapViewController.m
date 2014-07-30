//
//  MapViewController.m
//  BT
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MapViewController.h"
#define METERS_PER_MILE 1609.344
@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{

    //_map.showsUserLocation = YES;
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = _lastLocation.coordinate.latitude;
    zoomLocation.longitude= _lastLocation.coordinate.longitude;
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    

    [_map setRegion:viewRegion animated:YES];
    
  }

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)historyPush:(id)sender {
   
    NSArray* historicalAnnotation=[[NSArray alloc] init];
    historicalAnnotation=_map.annotations;
    if(historicalAnnotation)
    [_map removeAnnotations:historicalAnnotation];
    
          Localization* historicalPlaceObj =[[Localization alloc]init];
        for (int i=0; i<[_localizationArray count]; i++) {
      
            historicalPlaceObj=[_localizationArray objectAtIndex:i];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy 'at' HH:mm"];
            
            NSString *fullName = [dateFormatter stringFromDate:historicalPlaceObj.timeStamp];
            fullName=[fullName stringByAppendingString:@"\n"];
            fullName=[fullName stringByAppendingString:historicalPlaceObj.beacon];
            SetHistoryPlace* annotation=[[SetHistoryPlace alloc]initWithName:historicalPlaceObj.userID andSubtitle:fullName coordinate:historicalPlaceObj.gps andPlaceList:_localizationArray];
            
    [_map addAnnotation:annotation];
    }
   
}


-(void)setStudent:(StudentAccount *)student
{
    if(self.student!=student)
    {
        self.student=student;
        [self historyPush:self];
        
    }
}



@end
