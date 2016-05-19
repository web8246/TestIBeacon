//
//  ViewController.m
//  TestIBeacon
//
//  Created by dean on 2016/5/16.
//  Copyright © 2016年 dean. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
    CLBeaconRegion * beaconRegion1;
//    CLBeaconRegion * beaconRegion2;  看想要掃描到多少個不同uuid的beacon
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;//記得要設置delegate
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    
    //Prepare BeaconRegions
    //CLRegion  == 一個地點，一個半徑，畫出一個圓的區域
    //只要格式符合，可以自己在這邊改動數字內容
    //8-4-4-4-12=36
    NSUUID *beacon1UUID = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    
    
    beaconRegion1 = [[CLBeaconRegion alloc] initWithProximityUUID:beacon1UUID identifier:@"com.beacon1"];
    beaconRegion1.notifyOnEntry = true;
    beaconRegion1.notifyOnExit = true;
    beaconRegion1.notifyEntryStateOnDisplay = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanBeaconSwitchAction:(id)sender {
    
    if ([sender isOn]) {
        [locationManager startMonitoringForRegion:beaconRegion1];
//        [locationManager startRangingBeaconsInRegion:beaconRegion1];
        
    }
    else
    {
        [locationManager stopMonitoringForRegion:beaconRegion1];
        
        
        [locationManager stopRangingBeaconsInRegion:beaconRegion1];
        
    }

}

#pragma mark - CLLocationManagerDelegate Methods
//[locationManager startMonitoringForRegion:beaconRegion1];
-(void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"didStartMonitoringForRegion");
    [locationManager requestStateForRegion:region];
}


//當地區轉移時，才觸發這二個方法[self.locationManager startMonitoringForRegion:self.beaconRegion];
//如果人將要進入範圍
-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"didEnterRegion");
    self.label2.text = @"didEnterRegion";
    self.label3.text = @"";
    NSString *message = [NSString stringWithFormat:@"Beacon didEnterRegion: %@",region.identifier];
    [self showLocationNotificationWithMessage:message];
    [locationManager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
}
//人正要離開範圍內
-(void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"didExitRegion");
    self.label3.text = @"didExitRegion";
    self.label2.text = @"";
    NSString *message = [NSString stringWithFormat:@"Beacon didExitRegion: %@",region.identifier];
    [self showLocationNotificationWithMessage:message];
    [locationManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
    
}

//didEnterRegion / didExitRegion被呼叫時，被觸發
//當requestStateForRegion被呼叫時，也會觸發
//當BeaconRegion的notifyEntryStateOnDisplay被設為YES時，當使用者打開iPhone螢幕時，也會被觸發。

//如果人已經在範圍內，或是不在範圍內
-(void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
    NSLog(@"didDetermineState");
    self.label1.text = @"didDetermineState";
    if (state == CLRegionStateInside)
    {
        //如果人在區域內，量測距離ibeacon位置的距離
        [locationManager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
        
        
        self.label2.text = @"inside";
    }
    else if (state == CLRegionStateOutside)
    {
        //如果人不再區域內，就不去量測
        [locationManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
        
        self.label3.text = @"outside";
    }
    
}
//跳出提示公用
//UILocalNotification只要進入範圍，就算app沒在執行，一樣會偵測到後，跳出提醒，讓user進入app
-(void) showLocationNotificationWithMessage:(NSString*)message
{
    UILocalNotification *notification = [UILocalNotification new];
    //fireDate發動的時間
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}


//把正在測距離的beacon放入array丟給我，讓我可以知道
//[self.locationManager startRangingBeaconsInRegion:self.beaconRegion];call this method
-(void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"didRangeBeacons");
    for (CLBeacon *beacon in beacons) {
        NSString *proximityString;
        
        switch (beacon.proximity) {
            case CLProximityUnknown:
                proximityString = @"Unknow";
                break;
            case CLProximityImmediate:
                proximityString = @"Immediate";
                break;
            case CLProximityNear:
                proximityString = @"Near";
                break;
            case CLProximityFar:
                proximityString = @"Far";
                break;
                
            default:
                break;
        }
        
        NSString *info = [NSString stringWithFormat:@"%@,RSSI:%ld,%@",region.identifier,beacon.rssi,proximityString];
        NSLog(@"info: %@",info);
        if ([region.identifier isEqualToString:beaconRegion1.identifier]) {
            self.label4.text = info;
        }
    }
    
    
}



@end
