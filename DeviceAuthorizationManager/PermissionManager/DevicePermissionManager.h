//
//  DevicePermissionManager.h
//  TouchPainter
//
//  Created by houwenjie on 2019/3/15.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DevicePermissionRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface DevicePermissionManager : NSObject

+ (instancetype)shareInstance;

- (void)askForPermission:(DevicePermissionRequest *)permissionRequest;


+ (DevicePermissionRequest *)locatePermissionRequest:(PermissionResultBlock)permissionResultBlock;

+ (DevicePermissionRequest *)cameraPermissionRequest:(PermissionResultBlock)permissionResultBlock;

+ (DevicePermissionRequest *)albumPermissionRequest:(PermissionResultBlock)permissionResultBlock;

@end

NS_ASSUME_NONNULL_END
