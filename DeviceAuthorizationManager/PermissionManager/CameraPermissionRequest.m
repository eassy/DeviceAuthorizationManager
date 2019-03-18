//
//  CameraPermissionRequest.m
//  TouchPainter
//
//  Created by houwenjie on 2019/3/18.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "CameraPermissionRequest.h"
#import <AVFoundation/AVFoundation.h>

@implementation CameraPermissionRequest

- (DevicePermissionStatus)permissionStatus {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        return DevicePermissionStatusDenied;
    } else if (status == AVAuthorizationStatusNotDetermined) {
        return DevicePermissionStatusNotDetermined;
    } else if (status == AVAuthorizationStatusAuthorized) {
        return DevicePermissionStatusAuthorized;
    }
    return DevicePermissionStatusNotDetermined;
}

- (void)handlerSingleRequest:(void (^)(BOOL))resultBlock {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (YES == granted) {
            if (resultBlock) {
                resultBlock(YES);
            }
        } else {
            if (resultBlock) {
                resultBlock(NO);
            }
        }
    }];
}

@end
