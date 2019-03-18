//
//  ViewController.m
//  DeviceAuthorizationManager
//
//  Created by houwenjie on 2019/3/18.
//  Copyright © 2019 houwenjie. All rights reserved.
//

#import "ViewController.h"
#import "DevicePermissionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        if (i == 0) {
            [btn setTitle:@"请求定位权限" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(askForLocatePermission) forControlEvents:UIControlEventTouchUpInside];
        } else if ( i == 1) {
            [btn setTitle:@"请求相机权限" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(askForCameraPermission) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [btn setTitle:@"请求相册权限" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(askForAlbumPermission) forControlEvents:UIControlEventTouchUpInside];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn setFrame:CGRectMake(100, 150 + i * 50, 150, 40)];
    }
}


- (void)askForLocatePermission {
    [[DevicePermissionManager shareInstance] askForPermission:[DevicePermissionManager locatePermissionRequest:^(BOOL resultStatus) {
        
    }]];
    [[DevicePermissionManager shareInstance] askForPermission:[DevicePermissionManager cameraPermissionRequest:^(BOOL resultStatus) {
        
    }]];
    [[DevicePermissionManager shareInstance] askForPermission:[DevicePermissionManager albumPermissionRequest:^(BOOL resultStatus) {
        
    }]];
    
    
}


- (void)askForCameraPermission {
    [[DevicePermissionManager shareInstance] askForPermission:[DevicePermissionManager cameraPermissionRequest:^(BOOL resultStatus) {
        
    }]];
}


- (void)askForAlbumPermission {
    [[DevicePermissionManager shareInstance] askForPermission:[DevicePermissionManager albumPermissionRequest:^(BOOL resultStatus) {
        
    }]];
}

@end
