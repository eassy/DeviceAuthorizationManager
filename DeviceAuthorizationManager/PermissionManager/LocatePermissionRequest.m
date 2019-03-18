//
//  LocatePermissionRequest.m
//  TouchPainter
//
//  Created by houwenjie on 2019/3/18.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "LocatePermissionRequest.h"
#import <CoreLocation/CoreLocation.h>

@interface LocatePermissionRequest ()<CLLocationManagerDelegate>

/**
 result block
 */
@property (nonatomic, strong) PermissionResultBlock locateRequstBlock;
/**
 保存定位权限
 */
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocatePermissionRequest

- (DevicePermissionStatus)permissionStatus {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        return DevicePermissionStatusDenied;
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        return DevicePermissionStatusNotDetermined;
    } else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        return DevicePermissionStatusAuthorized;
    }
    return DevicePermissionStatusNotDetermined;
}

- (void)handlerSingleRequest:(void (^)(BOOL))resultBlock {
    self.locateRequstBlock = resultBlock;
    if (!self.locationManager) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            [self.locationManager requestWhenInUseAuthorization];
        });
    }
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            if (self.locateRequstBlock) {
                self.locateRequstBlock(NO);
                self.locateRequstBlock = nil;
            }
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse
            :
        {
            if (self.locateRequstBlock) {
                self.locateRequstBlock(YES);
                self.locateRequstBlock = nil;
            }
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            
        }
            break;
        default:
            break;
    }
}

@end
