//
//  Macro.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/15.
//

import Foundation
import UIKit

//正式
//public let Host = "http://111.74.0.243:8877/"
//本地
public let Host = "http://192.168.0.9:8877/"

public let VideoHost = "http://47.111.139.74:8089/"

// 屏幕宽高
public let SCR_W = UIScreen.main.bounds.size.width
public let SCR_H = UIScreen.main.bounds.size.height

//Label字体大小
public let label_Size1  =   15
public let label_Size2  =   10

//----------------------About Color 颜色 ----------------------------
//统一颜色
//333333
public let label_Color1   = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
//cccccc
public let label_Color2   = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)

public let seDiao_Color1  = UIColor.init(red: 64/255.0, green: 158/255.0, blue: 254/255.0, alpha: 1)
public let seDiao_Color2  = UIColor.init(red: 80/255.0, green: 219/255.0, blue: 142/255.0, alpha: 1)

// 随机颜色
public let Random_Color:(() ->UIColor) = { () -> UIColor in
    return UIColor.init(red:CGFloat(CGFloat(arc4random()%255)/255.0), green:CGFloat(CGFloat(arc4random()%255)/255.0), blue:CGFloat(CGFloat(arc4random()%255)/255.0), alpha:CGFloat(1))
}

// rgb颜色 - 自定义颜色
public let RGB_Color:((Float,Float,Float,Float) ->UIColor) = { (r:Float, g:Float, b:Float, a:Float) -> UIColor in
    return UIColor.init(red:CGFloat(CGFloat(r)/255.0), green:CGFloat(CGFloat(g)/255.0), blue:CGFloat(CGFloat(b)/255.0), alpha:CGFloat(a))
}

// 十六进制颜色 - 自定义颜色(0x000000,1)
public let Hex_Color:((Int,Float) ->UIColor) = { (rgbValue :Int, alpha :Float) ->UIColor in
    return UIColor(red:CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green:CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue:CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha:CGFloat(alpha))
}
