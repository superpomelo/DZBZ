//
//  LoginAndRRequestDatas.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/17.
//

import UIKit
import Alamofire
import HandyJSON

class LoginAndRRequestDatas: NSObject {
    /**登陆*/
    func RequestWithLogin(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "open_api/user/login"

        BaseRequestDatas().RequestWithPathUrl(isToken:false,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["status"] as? Int
            if status == 200 {
                let model = passWordLoginModel.deserialize(from: resultDic["data"] as? NSDictionary)
                
                success(model as Any)
            }else{
                failure(resultDic["message"] as Any)
            }
        } failure: { (error) in
            
        }
    }
    
    /**注册*/
    func RequestWithResign(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "open_api/user/register"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:false,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["status"] as? Int
            if status == 200 {
                let model = registerModel.deserialize(from: resultDic["data"] as? NSDictionary)
                
                success(model as Any)
            }

        } failure: { (error) in
            
        }
    }
    
    /**忘记密码*/
    func RequestWithLost(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "auth_api/user/update_pwd"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:true,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["status"] as? Int
            if status == 200 {
//                let model = registerModel.deserialize(from: resultDic["data"] as? NSDictionary)
                
                success("model" as Any)
            }

        } failure: { (error) in
            
        }
    }
    
    /**退出登陆*/
    func RequestWithExit(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "auth_api/user/logout"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:true,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["status"] as? Int
            if status == 200 {
//                let model = registerModel.deserialize(from: resultDic["data"] as? NSDictionary)
                
                success("model" as Any)
            }

        } failure: { (error) in
            
        }
    }
}
