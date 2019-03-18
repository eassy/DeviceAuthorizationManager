
//
//  DevicePermissionManager.m
//  TouchPainter
//
//  Created by houwenjie on 2019/3/15.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "DevicePermissionManager.h"
#import "LocatePermissionRequest.h"
#import "CameraPermissionRequest.h"
#import "AlbumPermissionRequest.h"

@interface DevicePermissionManager ()

/**
 任务数组
 */
@property (nonatomic, strong) NSMutableArray *requestList;
/**
 锁
 */
@property (nonatomic, strong) NSLock *lock;
/**
 信号量控制每次处理的 request 为 1个
 */
@property (nonatomic, strong) dispatch_semaphore_t requestSemaphore;

@end

@implementation DevicePermissionManager

+ (instancetype)shareInstance {
    static DevicePermissionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DevicePermissionManager alloc] init];
        manager.requestList = [NSMutableArray array];
        manager.lock = [[NSLock alloc] init];
        manager.requestSemaphore = dispatch_semaphore_create(1);
    });
    return manager;
}

#pragma mark - factory method

+ (DevicePermissionRequest *)locatePermissionRequest:(PermissionResultBlock)permissionResultBlock {
    return [[LocatePermissionRequest alloc] initWithRequestType:DevicePermissionRequestTypeLocate resultBlock:permissionResultBlock];
}

+ (DevicePermissionRequest *)cameraPermissionRequest:(PermissionResultBlock)permissionResultBlock {
    return [[CameraPermissionRequest alloc] initWithRequestType:DevicePermissionRequestTypeCamera resultBlock:permissionResultBlock];
}

+ (DevicePermissionRequest *)albumPermissionRequest:(PermissionResultBlock)permissionResultBlock {
    return [[AlbumPermissionRequest alloc] initWithRequestType:DevicePermissionRequestTypeAlbum resultBlock:permissionResultBlock];
}
#pragma mrak - private method

- (void)askForPermission:(DevicePermissionRequest *)permissionRequest {
    [self addPermissionRequest:permissionRequest];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_semaphore_wait(self.requestSemaphore, DISPATCH_TIME_FOREVER);
        
        [permissionRequest handlerSingleRequest:^(BOOL status) {
            if (YES == status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (permissionRequest.resultBlock) {
                        permissionRequest.resultBlock(YES);
                    }
                });
                [self removePermissionRequest:permissionRequest];
                dispatch_semaphore_signal(self.requestSemaphore);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (permissionRequest.resultBlock) {
                        permissionRequest.resultBlock(NO);
                    }
                });
                [self removePermissionRequest:permissionRequest];
                dispatch_semaphore_signal(self.requestSemaphore);
            }
        }];
    });
}

- (void)addPermissionRequest:(DevicePermissionRequest *)permissionRequest {
    [self.lock lock];
    [self.requestList addObject:permissionRequest];
    [self.lock unlock];
}


- (void)removePermissionRequest:(DevicePermissionRequest *)permissionRequest {
    [self.lock lock];
    [self.requestList removeObject:permissionRequest];
    [self.lock unlock];
}

@end
