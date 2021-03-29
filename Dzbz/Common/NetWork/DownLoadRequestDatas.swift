//
//  DownLoadRequestDatas.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/26.
//

import UIKit
import Alamofire
import HandyJSON

class DownLoadRequestDatas: NSObject {
    /**下载数据*/
    func RequestWithDownLoadA(pathurl:String,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
//        let PathUrl = Host + "auth_api/user/get_user_info"
       
        BaseRequestDatas().RequestWithDownLoad(isToken: true, pathurl: pathurl) { (result) in
            success(result)
        } failure: { (error) in
            failure("")
        }

        
        
        
//        (isToken:true,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
//            
//            var resultDic = [String: Any]()
//            resultDic = result as! [String : Any]
//            print(result)
//            let status = resultDic["status"] as? Int
//            if status == 200 {
//                let model = PersonCenterModel.deserialize(from: resultDic["data"] as? NSDictionary)
//
//                
//                success(model as Any)
//            }
//
//        } failure: { (error) in
//            
//        }
    }
}
