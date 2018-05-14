//
//  ZYXTestModel.m
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/14.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import "ZYXTestModel.h"

@implementation ZYXTestModel
- (void)parse:(NSDictionary *)dict {
    [super parse:dict];
    self.name = [self getDictValueForKey:dict[@"name"]];
    self.sex = [self getDictValueForKey:dict[@"sex"]];
    [self addDictValues:dict[@"books"] toArray:self.books className:@"ZYXBook"];
}
@end


@implementation ZYXBook
- (void)parse:(NSDictionary *)dict {
    [super parse:dict];
    self.type = [self getDictValueForKey:dict[@"type"]];
    self.pages = [self getDictValueForKey:dict[@"pages"]];
}
@end
