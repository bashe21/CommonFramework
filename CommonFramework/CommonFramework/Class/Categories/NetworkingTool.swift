//
//  NetworkingTool.swift
//  NGBDian
//
//  Created by 张哈哈 on 2017/6/26.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestType:String {
    case get = "GET"
    case post = "POST"
}

// 创建单例
class NetworkingTool: AFHTTPSessionManager {
    static let shareInstance:NetworkingTool = {
       let tool = NetworkingTool()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
    }()
}
// MARK: - 分装数据请求方法
extension NetworkingTool {
    func request(networkingType:RequestType,urlString:String,parameters:[String:AnyObject]?,finished:@escaping (_ result:AnyObject?,_ error:Error?)->()) {
        // 1、定义成功的闭包
        let successCallBack = {(task:URLSessionDataTask,result:Any?)-> Void in finished(result as AnyObject,nil)
        }
        // 2、定义失败的闭包
        let failureCallBack = {(task:URLSessionDataTask?,error:Error?)-> Void in finished(nil,error)
        }
        // 3、发送网络请求
        if networkingType == .get {
           get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        if networkingType == .post {
           get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        
    }
}











