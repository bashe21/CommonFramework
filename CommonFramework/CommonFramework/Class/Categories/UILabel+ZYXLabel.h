//
//  UILabel+ZYXLabel.h
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/14.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZYXLabel)

- (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;
// 居中对齐
- (NSAttributedString *)setAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;
- (CGSize )szieAdaptiveWithText:(NSString *)text andTextFont:(UIFont *)font andTextMaxSzie:(CGSize )size;

@end
