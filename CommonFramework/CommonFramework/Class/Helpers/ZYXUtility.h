//
//  ZYXUtility.h
//  提示Demo
//
//  Created by 张哈哈 on 2017/3/6.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYXUtility : NSObject
+ (instancetype)shareInstance;
- (void)showAlertViewWith:(UIViewController *)viewConroller title:(NSString *)title plainAction:(UIAlertAction *)plainAction cancelAction:(UIAlertAction *)cancelAction ;
+ (BOOL)judgeNil:(id)value;

@end
