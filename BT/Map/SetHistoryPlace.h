//
//  SetHistoryPlace.h
//  BT
//
//  Created by LGBS dev on 7/22/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SetHistoryPlace : NSObject<MKAnnotation>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *place;
@property (nonatomic,retain)NSMutableArray* localizationArray;
@property (nonatomic,assign)float gpsLongitude;
@property  (nonatomic,assign)float gpsLatitude;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
- (id)initWithName:(NSString*)name andSubtitle:(NSString*)place coordinate:(CLLocationCoordinate2D)coordinate andPlaceList:(NSMutableArray*)placeList;
- (MKMapItem*)mapItem;
@end
