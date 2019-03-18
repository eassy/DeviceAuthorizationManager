//
//  DevicePerssionRequest.h
//  TouchPainter
//
//  Created by houwenjie on 2019/3/15.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,DevicePermissionRequestType) {
    /// 访问相机权限
    DevicePermissionRequestTypeCamera = 1,
    /// 访问相册权限
    DevicePermissionRequestTypeAlbum,
    /// 定位权限
    DevicePermissionRequestTypeLocate,
    
};

typedef NS_ENUM(NSInteger, DevicePermissionStatus) {
    /// 被拒绝
    DevicePermissionStatusDenied = 1,
    /// 请求未处理过
    DevicePermissionStatusNotDetermined,
    /// 设备不支持，被限制
    DevicePermissionStatusRestricted,
    /// 权限被授权
    DevicePermissionStatusAuthorized
};

typedef void(^PermissionResultBlock)(BOOL resultStatus);

@interface DevicePermissionRequest : NSObject

/**
 权限类型
 */
@property (nonatomic, assign, readonly) DevicePermissionRequestType requestType;

/**
 回调 block
 */
@property (nonatomic, copy, readonly) PermissionResultBlock resultBlock;


- (instancetype)initWithRequestType:(DevicePermissionRequestType)requestType resultBlock:(PermissionResultBlock)resultBlock;

+ (instancetype)requestWithRequestType:(DevicePermissionRequestType)requestType resultBlock:(PermissionResultBlock)resultBlock;

- (void)handlerSingleRequest:(void(^)(BOOL status))resultBlock;

- (DevicePermissionStatus)permissionStatus;

@end

NS_ASSUME_NONNULL_END
