//
//  ZYXBaseModel.m
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/14.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import "ZYXBaseModel.h"
#import <objc/runtime.h>

@implementation ZYXBaseModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (![dict isKindOfClass:[NSDictionary class]]) {
            dict = [[NSDictionary alloc] init];
        }
        [self parse:dict];
    }
    return self;
}

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [self parse:dict];
        }
    }
    return self;
}


- (void)parse:(NSDictionary *)dict {
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
}

- (NSMutableDictionary *)jsonDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    Class oneClass = self.class;
    while (oneClass != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(oneClass, &count);
        for (int i = 0;i < count;i++) {
            objc_property_t property = properties[i];
            NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            id value = [self valueForKey:key];
            if (value != nil) {
                if ([value isKindOfClass:[ZYXBaseModel class]]) {
                    value = [value jsonDictionary];
                } else if ([value isKindOfClass:[NSArray class]]) {
                    id last = [value lastObject];
                    if ([last isKindOfClass:[ZYXBaseModel class]]) {
                        NSMutableArray *temp = [NSMutableArray array];
                        for (ZYXBaseModel *model in temp) {
                            [temp addObject:[model jsonDictionary]];
                        }
                    }
                }
                if ([ZYXUtility judgeNil:value]) {
                    [dict setObject:value forKey:key];
                } else {
                    [dict setObject:@"" forKey:key];
                }
            } else {
                [dict setObject:@"" forKey:key];
            }
        }
        free(properties);
        oneClass = [oneClass superclass];
    }
    return dict;
}

- (NSString *)getDictValueForKey:(NSString *)key {
    if (![ZYXUtility judgeNil:key]) {
        return [key description];
    }
    return @"";
}

- (void)addDictValues:(NSArray *)values toArray:(NSMutableArray *)array className:(NSString *)className {
    if (![values isKindOfClass:[NSArray class]]) {
        return;
    }
    for (int i = 0; i < values.count; i++) {
        id item = values[i];
        if ([item isKindOfClass:[NSArray class]]) {
            NSMutableArray *temp = [NSMutableArray array];
            [array addObject:temp];
            [self addDictValues:item toArray:temp className:className];
        } else if ([item isKindOfClass:[NSDictionary class]] && className != nil) {
            Class one = NSClassFromString(className);
            id temp = [[one alloc] initWithDictionary:item];
            [array addObject:temp];
        } else if (![ZYXUtility judgeNil:item]) {
            [array addObject:[item description]];
        }
    }
}

@end
