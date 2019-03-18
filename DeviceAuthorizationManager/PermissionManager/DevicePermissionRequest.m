//
//  DevicePermissionRequest.m
//  TouchPainter
//
//  Created by houwenjie on 2019/3/15.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "DevicePermissionRequest.h"

@interface DevicePermissionRequest ()

/**
 权限类型
 */
@property (nonatomic, assign, readwrite) DevicePermissionRequestType requestType;

/**
 回调 block
 */
@property (nonatomic, copy, readwrite) PermissionResultBlock resultBlock;

@end

@implementation DevicePermissionRequest

- (instancetype)initWithRequestType:(DevicePermissionRequestType)requestType resultBlock:(PermissionResultBlock)resultBlock {
    if (self = [super init]) {
        self.requestType = requestType;
        self.resultBlock = resultBlock;
    }
    return self;
}

+ (instancetype)requestWithRequestType:(DevicePermissionRequestType)requestType resultBlock:(PermissionResultBlock)resultBlock {
    DevicePermissionRequest *request = [[DevicePermissionRequest alloc] initWithRequestType:requestType resultBlock:resultBlock];
    return request;
}

- (void)dealloc {
    
}

- (void)handlerSingleRequest:(void(^)(BOOL status))resultBlock {
    // 子类去实现
}

- (DevicePermissionStatus)permissionStatus {
    // 子类去实现
    return DevicePermissionStatusNotDetermined;
}

@end
