//
//  UIButton+ZYXButton.m
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/13.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import "UIButton+ZYXButton.h"

@implementation UIButton (ZYXButton)
- (void)verticalImageUpAndTitleDown:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font} ];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

- (void)verticalTitleTopAndImageDown:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, (totalHeight - titleSize.height), 0);
    self.imageEdgeInsets = UIEdgeInsetsMake((totalHeight - imageSize.height), 5, 0, - titleSize.width);
}

- (void)horizontalTitleLeftAndImageRight:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + spacing), 0, (imageSize.width + spacing));
    self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleSize.width + spacing), 0, -(titleSize.width + spacing));
}
@end
