//
//  ZYXUtility.m
//  提示Demo
//
//  Created by 张哈哈 on 2017/3/6.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "ZYXUtility.h"

@implementation ZYXUtility
+ (instancetype)shareInstance {
    static ZYXUtility *utility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utility = [[self alloc] init];
    });
    return utility;
}
// 提示框
- (void)showAlertViewWith:(UIViewController *)viewConroller title:(NSString *)title plainAction:(UIAlertAction *)plainAction cancelAction:(UIAlertAction *)cancelAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    if (plainAction) {
        [alert addAction:plainAction];
    }
    if (cancelAction) {
        [alert addAction:cancelAction];
    }
    [viewConroller presentViewController:alert animated:YES completion:nil];
}
@end
