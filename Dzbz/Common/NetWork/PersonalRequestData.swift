//
//  PersonalRequestData.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit
import Alamofire
import HandyJSON

class PersonalRequestData: NSObject {
    
    /**获取个人信息*/
    func RequestWithget_user_info(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "auth_api/user/get_user_info"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:true,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["status"] as? Int
            if status == 200 {
                let model = PersonCenterModel.deserialize(from: resultDic["data"] as? NSDictionary)

                
                success(model as Any)
            }

        } failure: { (error) in
            
        }
    }
    /**修改头像*/
    
    func RequestWithupdate_user_img(parameters:[String:String]?=nil,imageData: [String:Data],success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "auth_api/user/update_user_img"
       
        BaseRequestDatas().PostRequestWithUpload(pathurl: PathUrl, parameters: parameters, imageData: imageData, success: { (result) in
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            guard  let status = resultDic["status"] as? Int else {return}
            if status == 200 {
             success("200" as Any)
            }else{
                failure(resultDic["message"] as Any)
            }
        }) { (error) in
            
        }
    }
}
