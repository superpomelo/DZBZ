//
//  PersonCenterModel.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/19.
//

import UIKit
import HandyJSON

class PersonCenterModel: HandyJSON {
    var birthday: String = ""
    var createTime: String = ""
    var imgPath:String = ""
    var name: String = ""
    var phoneNumber: String?
    var roleId: String?
    var roleName: String?
    var sex: Int?
    var userId: String?
    var userName: String = ""
    var token: String?

    required  init(){} // 必须实现一个空的初始化方法
}
