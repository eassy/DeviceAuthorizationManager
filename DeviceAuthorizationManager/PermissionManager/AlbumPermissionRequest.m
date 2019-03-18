//
//  AlbumPermissionRequest.m
//  TouchPainter
//
//  Created by houwenjie on 2019/3/18.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "AlbumPermissionRequest.h"
#import <Photos/Photos.h>

@implementation AlbumPermissionRequest

- (DevicePermissionStatus)permissionStatus {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        return DevicePermissionStatusDenied;
    } else if (status == PHAuthorizationStatusNotDetermined) {
        return DevicePermissionStatusNotDetermined;
    } else if (status == PHAuthorizationStatusAuthorized) {
        return DevicePermissionStatusAuthorized;
    }
    return DevicePermissionStatusDenied;
}

- (void)handlerSingleRequest:(void (^)(BOOL))resultBlock {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusDenied:
            case PHAuthorizationStatusRestricted: {
                if (resultBlock) {
                    resultBlock(NO);
                }
            }
                break;
            case PHAuthorizationStatusAuthorized: {
                if (resultBlock) {
                    resultBlock(YES);
                }
            }
                break;
            case PHAuthorizationStatusNotDetermined: {
                
            }
            default:
                break;
        }
    }];
}

@end
