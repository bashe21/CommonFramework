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
    UIViewController *currentVc = APPDELEGATE.window.rootViewController;
    if ([currentVc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)currentVc;
        UINavigationController *nav = (UINavigationController *)tabBarController.selectedViewController;
        UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
        return baseVC;
    } else{
        return currentVc;
    }
}
@end
