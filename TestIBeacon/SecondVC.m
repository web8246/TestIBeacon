//
//  SecondVC.m
//  TestIBeacon
//
//  Created by dean on 2016/5/16.
//  Copyright © 2016年 dean. All rights reserved.
//

#import "SecondVC.h"
#import <CoreLocation/CoreLocation.h>

@interface SecondVC ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion * beaconRegion;
@property (strong, nonatomic) CLLocationManager * locationManager;

@end

@implementation SecondVC
static NSString * uuid = @"";
static NSString * treasureId = @"KidTestiBeacon";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    
    // for background monitor, would call didEnter/ExitRegion
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // [self.locationManager stopMonitoringForRegion:self.beaconRegion];
}

#pragma mark - getter

- (CLLocationManager *)locationManager
{
    // 新增一個 locationManager
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        _locationManager.activityType = CLActivityTypeFitness;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

- (CLBeaconRegion *)beaconRegion
{
    if (!_beaconRegion)
    {
        // Regardless of whether the device is a transmitter or receiver, we need a beacon region.
        NSUUID * uid = [[NSUUID alloc] initWithUUIDString:uuid];
        _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid identifier:treasureId];
        
        // When set to YES, the location manager sends beacon notifications when the user turns on the display and the device is already inside the region.
        [_beaconRegion setNotifyEntryStateOnDisplay:YES];
        
        // 這兩個值default就是YES, 所以可以不用寫這兩行
        [_beaconRegion setNotifyOnEntry:YES];
        [_beaconRegion setNotifyOnExit:YES];
    }
    
    return _beaconRegion;
}



#pragma mark - CLLocationManagerDelegate methods
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    // See if we've entered the region.
    if ([region.identifier isEqualToString:treasureId]) {
        UILocalNotification * notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"didEnterRegion";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    // See if we've exited a treasure region.
    if ([region.identifier isEqualToString:treasureId]) {
        UILocalNotification * notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"didExitRegion";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if (![region.identifier isEqualToString:treasureId])
        return;
    
    NSString *message;
    
    switch (state) {
        case CLRegionStateUnknown:{
            
            UILocalNotification * notification = [[UILocalNotification alloc] init];
            message = @"你...在哪裡";
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            break;
        }
        case CLRegionStateInside:{
            UILocalNotification * notification = [[UILocalNotification alloc] init];
            message = @"你在iBeacon的範圍裡";
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            break;
        }
        case CLRegionStateOutside:
        {
            UILocalNotification * notification = [[UILocalNotification alloc] init];
            message = @"你在iBeacon的範圍外面";
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            break;
        }
    }
    
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    if ([beacons count] == 0)
        return;
    
    // beacons is a list of beacons in proximity order. That is, the first beacon in the list will be the nearest to you.
    CLBeacon * beacon = [beacons firstObject];
    NSString * message;
    
    //    NSLog(@"beacon: %@", beacon);
    switch (beacon.proximity) {
        case CLProximityUnknown:
            message = @"Unknown";
            break;
        case CLProximityFar:
            message = @"Far";
            break;
        case CLProximityNear:
            message = @"Near";
            break;
        case CLProximityImmediate:
            message = @"Immediate";
            break;
    }
    
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}
@end
