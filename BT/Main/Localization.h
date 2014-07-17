//
//  Localization.h
//  BT
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Localization : NSObject
@property(nonatomic,retain)NSString* deviceID;
@property(nonatomic,retain)NSDate* timeStamp;
@property(nonatomic,assign)CLLocationCoordinate2D gps;
@property(nonatomic,retain)NSString* beacon;

+(Localization*)initLocalizationWithID : (NSString*)deviceID andTime:(NSString*)timeStamp andGpsLong :(NSString*)gpsLong andGpsLati:(NSString*)gpsLati andBeacon:(NSString*)beacon;
@end
