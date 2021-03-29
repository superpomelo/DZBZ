//
//  BaseRequestDatas.swift
//  PtaxiMaster
//
//  Created by superpomelo on 2018/10/11.
//  Copyright © 2018年 XQ. All rights reserved.
//

import UIKit
import Alamofire
class BaseRequestDatas: NSObject {
    // 创建单例
    static let shared = BaseRequestDatas()
    
    lazy var alamofireManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        let session = SessionManager(configuration: config)
        return session
    }()
    
    
    /**method为请求方式  请求--pathurl为请求url,success为请求成功回调闭包，failure为请求失败回调闭包*/
    func RequestWithPathUrl(isToken:Bool,pathurl:String,parameters:[String:String]? = nil,httpMethod:String,encoding:ParameterEncoding?=URLEncoding.methodDependent,headers:HTTPHeaders?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
       //   method    HTTPMethod.get
       //   encoding  URLEncoding.default
//        let jsonString = JsonString.convert(toJsonData: parameters!)
        var Para = [String:String]()
        var json = String()
        if parameters != nil {
            Para = parameters!
            var i = 0
            for (key, value) in Para {
                i += 1
                if i < Para.count {
                    json += key + "=" + value + "&"
                } else {
                    json += key + "=" + value
                }
            }
        }
//        let json = "phoneNumber=16870714471&pwd=12345"
        let url = URL(string: pathurl)!
        let jsonData =  json.data(using: .utf8)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //是否要token
        if isToken {
            if UserInfoManager.getToken() != nil {
                request.addValue(UserInfoManager.getToken(), forHTTPHeaderField: "Authorization")

            }
        }
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON {
            (response) in
            switch response.result {
              case .success:
                /// 解密
                var resultDic = [String: Any]()
                if let data =  response.result.value as? [String: Any] {
                    if data.keys.contains("privDecrypts") {
                        
                    }else{
                        resultDic = data
                    }
                }
                print("successPFX")
                success(resultDic as Any)
                break

            case .failure:

                print("errorPFX")
                print(pathurl)
                print(parameters as Any)
                failure(response.result.error as Any)
                break
            }
        }
                
    }

   

    
    //MARK:- Post带token请求--pathurl为请求url imageData为图片文件,success为请求成功回调闭包，failure为请求失败回调闭包
    /**Post带token请求--pathurl为请求url imageData为图片文件,success为请求成功回调闭包，failure为请求失败回调闭包*/
    func PostRequestWithUpload(pathurl:String,parameters:[String:String]? = nil,imageData: [String : Data],success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
       
        var para = [String : Any]()   //方式二
        if (parameters != nil) {
            para = parameters!
        }
        
//        para["token"] = UserInfoManager.getToken()
//        para["uid"] = String.init(format: "%ld", UserInfoManager.getUid())
        
        //判断isEncrypt获取是否需要加密
        var isEncryptParameters = [String:Any]()

 
        Alamofire.upload(multipartFormData: { (formData) in
            for (key, data) in imageData {
                formData.append(data, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
            }
            for (key, value) in isEncryptParameters {
                let v = value as! String

                formData.append(v.data(using: .utf8)!, withName: key)
            }
        }, to: pathurl, method: .post,headers: ["Authorization": UserInfoManager.getToken()]) { (result) in
            switch result {
              case .success (let upload, _,  _):
                 upload.responseJSON { (response) in
                     switch response.result {
                        case .success:
                            /// 解密
                            var resultDic = [String: Any]()

                            if let data =  response.result.value as? [String: Any] {

                                if data.keys.contains("privDecrypts") {

                                }else{
                                    resultDic = data
                                }

                            }

//                            var resultDic = [String: Any]()
//                            resultDic = response.result.value as! [String : Any]

                            guard let status = resultDic["status"] as? Int else {return}
                            if status == 16 {
                                //TOKEN失效
//                                CheckOutRootViewController().goLoginVC() //跳转到登录页面
                            }
                            success(resultDic as Any)

                          break
                        case .failure:
                             print("errorPFX2")
                             print(pathurl)
                             print(para as Any)
//                             MBProgressHUBs().showProgressHUD(title: "服务器错误")
                             failure(response.result.error as Any)

                          break
                     }
                }
              case .failure:
                 print("errorPFX1")
                 print(pathurl)
                 print(para as Any)
              //   MBProgressHUBs().showProgressHUD(title: "服务器错误")

                break
            }

        }

    }
   
    /**下载文件*/

    func RequestWithDownLoad(isToken:Bool,pathurl:String,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
             
        Alamofire.download(pathurl, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            //新文件名
            let newName = pathurl.split(separator: "/").last!.description
            let fileURL = documentsURL.appendingPathComponent(newName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        })
        .downloadProgress { (progress) in
            print("完成比例：(progress.fractionCompleted)")
            print("当前完成：(progress.completedUnitCount)")
            print("总共大小：(progress.totalUnitCount)")
            print(progress)
        }.responseData(queue: DispatchQueue.global(qos: .utility)) { (response) in
            print(response.destinationURL?.absoluteString)
            print(response.result.value)
            if response.destinationURL != nil {
                success(response.destinationURL)
            }else{
                failure("")
            }
        }
        
     
//        Alamofire.download(path,to: destination)
//            .downloadProgress(queue: utilityQueue) { progress in
//                print("完成比例：(progress.fractionCompleted)")
//                print("当前完成：(progress.completedUnitCount)")
//                print("总共大小：(progress.totalUnitCount)")
//            }
//            .responseData { response in
//    //            response.destinationURL//目的地址可直接使用
//                if response.destinationURL != nil {
//                    print(response.destinationURL)
//
//                }else{
//                    print("哈哈哈response.destinationURL=nil")
//
//                }
//                if response.result.value != nil {
//                    print(response.result.value)
//
//                }else{
//                    print("哈哈哈response.result.value=nil")
//
//                }
//                if let data = response.result.value {
//                    print(data)
////                    let pdf = UIImage(data: data)
//                }
//            }
        
    }
    
    
    
}



   




//Alamofire带的方法很好用这次java不支持
//        var request = Alamofire.request(pathurl, method: httpMethod, parameters: parameters, encoding: encoding!, headers: headers)
//        let parameters = "phoneNumber=16870714471&pwd=12345"
//        let postData =  parameters.data(using: .utf8)
//
//
//        Alamofire.request(pathurl, method: httpMethod, parameters: parameters, encoding: encoding!, headers: headers).responseJSON { (response) in
//
//            print(response)
//
//            switch response.result {
//            case .success:
//                /// 解密
//                var resultDic = [String: Any]()
//
//                if let data =  response.result.value as? [String: Any] {
//
//                    if data.keys.contains("privDecrypts") {
//
//                    }else{
//                        resultDic = data
//                    }
//                }
//                print("successPFX")
//                success(resultDic as Any)
//                break
//
//            case .failure:
//                print("errorPFX")
//                print(pathurl)
//                print(parameters as Any)
//                failure(response.result.error as Any)
//                break
//
//            }
//        }
