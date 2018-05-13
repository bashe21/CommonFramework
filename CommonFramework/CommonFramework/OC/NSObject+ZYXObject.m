//
//  NSObject+ZYXObject.m
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/13.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import "NSObject+ZYXObject.h"

@implementation NSObject (ZYXObject)
+ (UIViewController *)currentViewController {
    UIViewController *VC = APPDELEGATE.window.rootViewController;
    if ([VC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)VC;
        UINavigationController *nav = (UINavigationController *)tabBarController.selectedViewController;
        UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
        return baseVC;
    } else{
        return VC;
    }
}
@end
