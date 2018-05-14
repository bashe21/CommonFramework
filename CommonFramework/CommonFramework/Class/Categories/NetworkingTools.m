//
//  NetworkingTools.m
//  网络数据请求
//
//  Created by 张哈哈 on 2017/2/3.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "NetworkingTools.h"

@implementation NetworkingTools
// 创建网络请求单例对象
+ (NetworkingTools *)shareInstance {
    static NetworkingTools *_networkingTools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkingTools = [[self alloc] init];
    });
    return _networkingTools;
}
// 网络数据请求
- (void)requestWithType:(requestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters successCallBack:(void (^)(id responseObject))successCallBack failureCallBack:(void (^)(NSError *error))failureCallBack {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", @"application/x-javascript", nil];
    if (type == POST) {
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successCallBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureCallBack(error);
        }];
    }
    else {
        [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successCallBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureCallBack(error);
        }];
    }
}
// 网络状态监测
- (void)monitorNetworking {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", @"application/x-javascript", nil];
    // 添加网络监测
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:kNetworkReachableStatusChangeNotification object:@(status) userInfo:nil];
    }];
    
    [manager.reachabilityManager startMonitoring];
}
@end
