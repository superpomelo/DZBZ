//
//  JsonString.h
//  PtaxiMaster
//
//  Created by 狍子 on 2019/4/18.
//  Copyright © 2019 yzcx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonString : NSObject
// 数组转json字符串方法
+ (NSString *)convertArrayToJsonData:(NSMutableArray *)arrayM;
// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//json格式字符串转数组
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
