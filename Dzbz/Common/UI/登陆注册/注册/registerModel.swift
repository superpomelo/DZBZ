//
//  registerModel.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit
import HandyJSON

class registerModel: HandyJSON {
    var birthday: String = ""
    var createTime: String = ""
    var imgPath:Int?
    var name: String?
    var phoneNumber: String?
    var roleId: String?
    var sex: String?
    var userId: String?
    var userName: String?

    required init(){} // 必须实现一个空的初始化方法

}
