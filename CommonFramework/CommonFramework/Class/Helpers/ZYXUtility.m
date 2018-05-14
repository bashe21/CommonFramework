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
// 判断是否为空
+ (BOOL)judgeNil:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (([value rangeOfString:@"null"].length != 0 && [value length]<7) || [value isEqual:@""] || [value length] == 0) {
            return YES;
        }
    }
    if (value == nil || [value isEqual:[NSNull null]])
    return YES;
    else if (([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) && [value count] == 0)
    return YES;
    else
    return NO;
}
@end
