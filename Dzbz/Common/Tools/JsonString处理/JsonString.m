//
//  JsonString.m
//  PtaxiMaster
//
//  Created by 狍子 on 2019/4/18.
//  Copyright © 2019 yzcx. All rights reserved.
//

#import "JsonString.h"

@implementation JsonString
// 数组转json字符串方法
+ (NSString *)convertArrayToJsonData:(NSMutableArray *)arrayM
{
    
    //NSJSONWritingPrettyPrinted   有可读性
    //NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments   没可读性
    NSData *data=[NSJSONSerialization dataWithJSONObject:arrayM options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}
// 字典转json字符串方法

+ (NSString *)convertToJsonData:(NSDictionary *)dict
{
    
    //NSJSONWritingPrettyPrinted   有可读性
    //NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments   没可读性
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}
//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//json格式字符串转数组
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *ary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return ary;
}
@end
