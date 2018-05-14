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
// MARK: - 拉取键盘宝数据
extension NetworkingTool {
    func loadDataOfJianPanBao() {
        let urlString = "\(Common.stockHQAddress)/code/zqdmss?sstr=&tv=10&mc=SH,SZ&count=10000&field=Obj,StockName,ShortCode,TypeName,MarketCode&output=json"
        request(networkingType: .get, urlString: urlString, parameters: nil) { (responseObject, error) in
            if error == nil {
                if let dict = responseObject as? NSDictionary {
                    print("dict=\(dict)")
                    if let data = dict["Data"] as? NSDictionary {
                        if let RepDataCodeZqdmssOutput = data["RepDataCodeZqdmssOutput"] as? NSArray {
                            var arr:Array<[String:Any]> = []
                            for dict in  RepDataCodeZqdmssOutput {
                                arr.append(dict as! [String : Any])
                            }
                            CoreDataHelper.sharedInstance.removeAllStock()
                            CoreDataHelper.sharedInstance.addStockBatch(arr)
                        }
                    }
                }
            } else {
                print("error=\(error!)")
            }
        }
    }
    
    //初始化指数数据
    func initMarketingSourceData(updatedVersion:NSInteger) {
        if RealmDataHelper.shareInstance().getAllIndexs().count == 0{
            let indexs = ["上证指数","深证成指","创业板指","沪深300","上证180","A股指数","B股指数","深证100R","深证综指","深成指R","成分B指","深证A指","深证B指","中小板指","上证50","上证基金"]
            let indexCodes = ["SH000001","SZ399001","SZ399006","SH000300","SH000010","SH000002","SH000003","SZ399004","SZ399106","SZ399002","SZ399003","SZ399107","SZ399108","SZ399005","SH000016","SH000011"]
            let realm = RLMRealm.default()
            realm.beginWriteTransaction()
            for i in 0..<indexs.count {
                let name = indexs[i]
                let  code = indexCodes[i]
                let index = RealmIndex.init()
                index.code = code
                index.name = name
                index.order = Int32(i)
                index.isTop = Int32(i)<3 ? true:false
                realm.add(index)
            }
            do {
                try realm.commitWriteTransaction()
            } catch {
            }
        }
    }
    
    //从服务端拿到 两市所有股票
    func initStockData() {
        let urlString = "\(APIConstant.CJSAppHQIPPath)/kbspirit?type=0&market=SH,SZ,BK&count=0&output=pb"
        
        //全局队列异步执行
        DispatchQueue.global().async {
            //耗时操作
            CLHttpMethod.startAFHTTPRequst(urlString, params: nil, success: { (responseObject) in
                RealmDataHelper.shareInstance().clearHistoryStock()//清楚历史搜索数据
                let dynaRes:UAResponse = try! UAResponse.parse(from: responseObject as! Data)
                let msg:MSG = try! MSG.parse(from: dynaRes.data_p)
                
                let dataArr:NSArray = msg.repDataJianPanBaoShuChuArray! as NSArray
                
                if (dataArr.count)>0 {
                    UserDefaults.standard.set(NSDate.dateNow(), forKey: "lastUpdateData")
                    UserDefaults.standard.set(true, forKey: "boolEveryDayNine")
                    RealmDataHelper.shareInstance().clearALLStocks()
                    if let JPBShuChu:JianPanBaoShuChu = dataArr.firstObject as? JianPanBaoShuChu,
                        let ShuChu:JPBShuChu = JPBShuChu.jieGuoArray.firstObject as? JPBShuChu{
                        RealmDataHelper.shareInstance().addRealmStockBatch(ShuChu)
                    }
                    
                }
                
            }, failure: { (error) in
                
            })
            
            
            DispatchQueue.main.async {
                //回到主线程
            }
        }
    }
}











