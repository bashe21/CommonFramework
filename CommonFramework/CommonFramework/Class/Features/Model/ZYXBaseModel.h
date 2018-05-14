//
//  ZYXBaseModel.h
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/14.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import <Foundation/Foundation.h>
// 数据的基类
@interface ZYXBaseModel : NSObject
/**
 通过字典构建model

 @param dict 字典
 @return 模型对象
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 通过本地文件构建model

 @param path 文件路径
 @return 模型对象
 */
- (instancetype)initWithPath:(NSString *)path;

/**
 数据解析函数，所有子类都必须实现，解析自己的函数

 @param dict 原始字典数据
 */
- (void)parse:(NSDictionary *)dict;

/**
 模型转字典

 @return 字典数据
 */
- (NSMutableDictionary *)jsonDictionary;

- (NSString *)getDictValueForKey:(NSString *)key;
- (void)addDictValues:(NSArray *)values toArray:(NSMutableArray *)array className:(NSString *)className;
@end
