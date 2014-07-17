//
//  Localization.m
//  BT
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "Localization.h"

@implementation Localization

+(Localization*)initLocalizationWithID : (NSString*)deviceID andTime:(NSString*)timeStamp andGpsLong :(NSString*)gpsLong andGpsLati:(NSString*)gpsLati andBeacon:(NSString *)beacon
{
    Localization* lastPlace = [[Localization alloc]init];
    NSMutableArray* temp=[[NSMutableArray alloc]init];
    [temp addObject:deviceID];
    [temp addObject:timeStamp];
    [temp addObject:gpsLong];
    [temp addObject:gpsLati];
    [temp addObject:beacon];
    
    for (__strong NSString* thing in temp) {
        thing = [thing stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
        thing = [thing stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
        thing = [thing stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    //dokończyć !!!!!
//!!!!!!!
    lastPlace.deviceID=deviceID;
    //lastPlace.timeStamp=timeStamp;
    float localGpsLati=[gpsLati floatValue];
    float localGpsLong=[gpsLong floatValue];
    lastPlace.gps=CLLocationCoordinate2DMake(localGpsLati, localGpsLong);
    lastPlace.beacon=beacon;
    return lastPlace;
    
}
@end
