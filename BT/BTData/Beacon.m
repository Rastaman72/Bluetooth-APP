//
//  Beacon.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "Beacon.h"

@implementation Beacon


-(void)search
{
    
    self.beaconManager = [[ESTBeaconManager alloc]init];
    self.beaconManager.delegate=self;
    self.beaconManager.avoidUnknownStateBeacons=YES;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                                 major:[self.beacon.major unsignedIntValue]
                                                                 minor:[self.beacon.minor unsignedIntValue]
                                                            identifier:@"RegionIdentifier"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    if([beacons count]!=0)
    {
        for (ESTBeacon* beacon in beacons)
        {
            // ESTBeacon *firstBeacon = beacon;
            if(beacon !=nil)
            {
                if([self.btBeacon count] != 0)
                {
                    // if (![self.btBeacon containsObject:firstBeacon])
                    //    [self.btBeacon insertObject:firstBeacon atIndex:[self.btBeacon count]];
                    
                    NSArray *filteredArray=[self.btBeacon filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"major==%@",beacon.major]];
                    if([filteredArray count] == 0)
                    {
                        [self.btBeacon insertObject:beacon atIndex:[self.btBeacon count]];
                    }}
                else
                    [self.btBeacon insertObject:beacon atIndex:[self.btBeacon count]];
            }
        }
    }
}
@end
