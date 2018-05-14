//
//  UILabel+ZYXLabel.m
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/14.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import "UILabel+ZYXLabel.h"

@implementation UILabel (ZYXLabel)
- (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    //结尾部分的内容以……方式省略
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [self sizeToFit];
    return attributedString;
}

- (NSAttributedString *)setAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    //结尾部分的内容以……方式省略
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSRange range = NSMakeRange(0, [string length]);
    //[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    NSDictionary *dic = @{NSParagraphStyleAttributeName:paragraphStyle,NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleNone]};
    [attributedString setAttributes:dic range:range];
    //[self sizeToFit];
    return attributedString;
}
/**
 *  自适应宽高同时调整行距
 *
 *  @param text label.text
 *  @param font label.font
 *  @param size label的最大尺寸
 *
 *  @return 自适应后的到的size
 */
- (CGSize )szieAdaptiveWithText:(NSString *)text andTextFont:(UIFont *)font andTextMaxSzie:(CGSize )size{
    
    self.text = text;
    self.font = font;
    
    //可变的属性文本
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];//[[NSMutableAttributedString alloc]initWithString:self.text];
    
    //设置段落样式 使用NSMutableParagraphStyle类
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = NSTextAlignmentLeft;//文本对齐方式
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    paragraphStyle.lineSpacing = 5;  //行自定义行高度
    
    //  给可变的属性字符串 添加段落格式
    [attributedText addAttribute: NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
    //将带有段落格式的可变的属性字符串给label.attributedText
    self.attributedText = attributedText;
    
    self.lineBreakMode = NSLineBreakByTruncatingTail;//label的换行模式
    self.numberOfLines = 0;// 设置行数，0表示没有限制
    
    CGSize maxSzie = size;//设置label的最大SIZE
    
    [self sizeToFit];
    CGSize labelSize = [self sizeThatFits:maxSzie];//最终自适应得到的label的尺寸。
    
    
    return labelSize;
}

@end
