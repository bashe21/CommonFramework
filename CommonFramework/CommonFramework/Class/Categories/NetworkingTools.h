//
//  NetworkingTools.h
//  网络数据请求
//
//  Created by 张哈哈 on 2017/2/3.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger,requestType) {
    POST = 0,
    GET
};

@interface NetworkingTools : NSObject

+ (NetworkingTools *)shareInstance;
- (void)requestWithType:(requestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters successCallBack:(void (^)(id responseObject))successCallBack failureCallBack:(void (^)(NSError *error))failureCallBack;
- (void)monitorNetworking;
@end
