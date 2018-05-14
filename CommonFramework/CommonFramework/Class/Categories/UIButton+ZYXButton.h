//
//  UIButton+ZYXButton.h
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/13.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZYXButton)
// 图片在上文字在下
- (void)verticalImageUpAndTitleDown:(CGFloat)spacing;
// 图片在下文字在上
- (void)verticalTitleTopAndImageDown:(CGFloat)spacing;
// 图片在右文字在左
- (void)horizontalTitleLeftAndImageRight:(CGFloat)spacing;

@end
