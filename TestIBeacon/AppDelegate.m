//
//  AppDelegate.m
//  TestIBeacon
//
//  Created by dean on 2016/5/16.
//  Copyright © 2016年 dean. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLBeaconRegion *region1;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //獲得user的授權 Ask the permission of notification
    UIApplication *app = [UIApplication sharedApplication];
    
    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
    
    [app registerUserNotificationSettings:settings];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
//    
//    //獲得user的授權 Ask the permission of notification
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
//    
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
//    
//    [app registerUserNotificationSettings:settings];
//    
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
//                                                                                                              categories:nil]];
//    }
//    NSLog(@"applicationDidFinishLaunching");
//    
//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    
//    if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
//    {
//        [_locationManager requestAlwaysAuthorization];
//    }
//    
//    
//    //    CLBeaconRegion *region;
//    
//    
//    NSUUID *beacon1UUID = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
//    region1 = [[CLBeaconRegion alloc] initWithProximityUUID:beacon1UUID identifier:@"cc"];
//    //    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"] major: 1 minor: 1 identifier: @"region1"];
//    region1.notifyEntryStateOnDisplay = YES;
//    region1.notifyOnEntry = YES;
//    region1.notifyOnExit = YES;
//    [_locationManager startMonitoringForRegion:region1];
//    //    [_locationManager stopRangingBeaconsInRegion:region];
//    [_locationManager startRangingBeaconsInRegion:region1];
//    
//    //    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 2 identifier: @"region2"];
//    //    region.notifyEntryStateOnDisplay = YES;
//    //    [_locationManager startMonitoringForRegion:region];
//    //    [_locationManager stopRangingBeaconsInRegion:region];
//    //[_locationManager startRangingBeaconsInRegion:region];
//    
//    return YES;
//
//}
//
//- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
//{
//    if(state == CLRegionStateInside) {
//        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
//    }
//    else if(state == CLRegionStateOutside) {
//        NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
//    }
//    else {
//        NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
//    }
//}
//
//- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
//{
//    // I commented out the line below because otherwise you see this every second in the logs
//    NSLog(@"locationManager didRangeBeacons: %@",beacons);
//}
//
//
//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    NSLog(@"applicationWillResignActive");
//}
//
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    NSLog(@"applicationDidEnterBackground");
////    _locationManager.allowsBackgroundLocationUpdates = YES;
//    [_locationManager startMonitoringForRegion:region1];
//    //    [_locationManager stopRangingBeaconsInRegion:region];
//    [_locationManager startRangingBeaconsInRegion:region1];
//    
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application
//{
//    NSLog(@"applicationWillEnterForeground");
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    NSLog(@"applicationDidBecomeActive");
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//    NSLog(@"applicationWillTerminate");
//}

@end
