//
//  SetHistoryPlace.m
//  BT
//
//  Created by LGBS dev on 7/22/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SetHistoryPlace.h"

@implementation SetHistoryPlace
- (id)initWithName:(NSString*)name andSubtitle:(NSString *)subtitle coordinate:(CLLocationCoordinate2D)coordinate andPlaceList:(NSMutableArray *)placeList{
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.name = name;
        } else {
            self.name = @"Unknown charge";
        }
        
        self.place=subtitle;
        self.theCoordinate = coordinate;
        self.localizationArray=[[NSMutableArray alloc]initWithArray:placeList];
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _place;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

- (MKMapItem*)mapItem {
    
    NSDictionary *addressDict = [[NSDictionary alloc] init];
    addressDict = [_localizationArray mutableCopy];
    
      MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end
