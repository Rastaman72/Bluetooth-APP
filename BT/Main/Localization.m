//
//  Localization.m
//  BT
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "Localization.h"

@implementation Localization

+(Localization*)initLocalizationWithID : (NSString*)deviceID andTime:(NSString*)timeStamp andGpsLong :(NSString*)gpsLong andGpsLati:(NSString*)gpsLati andBeacon:(NSString *)beacon andUser:(NSString*)userID
{
    Localization* lastPlace = [[Localization alloc]init];
//    NSMutableArray* temp=[[NSMutableArray alloc]init];
//    NSMutableArray* resultPlace=[[NSMutableArray alloc]init];
//    [temp addObject:deviceID];
//    [temp addObject:timeStamp];
//    [temp addObject:gpsLong];
//    [temp addObject:gpsLati];
//    [temp addObject:beacon];
//    [temp addObject:userID];
//    
//       for (__strong NSString* thing in temp) {
//        thing = [thing stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
//        thing = [thing stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
//        thing = [thing stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//           [resultPlace addObject:thing];
//    }
   
    //lastPlace.deviceID=[resultPlace objectAtIndex:0];
    lastPlace.deviceID=deviceID;
   // lastPlace.timeStamp=[NSDate dateWithTimeIntervalSince1970:[[resultPlace objectAtIndex:1]doubleValue]];
    lastPlace.timeStamp=[NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    float localGpsLati=[gpsLati floatValue];
    float localGpsLong=[gpsLong floatValue];
    lastPlace.gps=CLLocationCoordinate2DMake(localGpsLati, localGpsLong);
    lastPlace.beacon=beacon;
    lastPlace.userID=userID;
    return lastPlace;
    
}
@end
