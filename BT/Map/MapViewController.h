//
//  MapViewController.h
//  BT
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SetHistoryPlace.h"
#import "Localization.h"
@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic,retain)NSMutableArray* localizationArray;
@property(nonatomic,retain)CLLocation *lastLocation;
- (IBAction)historyPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;


@end
