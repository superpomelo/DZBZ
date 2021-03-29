//
//  MyTimeInterval.h
//  labor
//
//  Created by 狍子 on 2020/9/9.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTimeInterval : NSObject
/**获取当前时间戳*/
+ (NSString *)getNowDateSJC;
/**时间戳转时间*/
+ (NSString*)IntervalStringToDateString:(NSString*)IntervalString;
/**获取今天之后的7天<含今天>*/
+ (NSMutableArray*)getsevenDays;

/**时间转成需要的时间*/
+ (NSString*)IntervalStringToIneedDateString:(NSString*)IntervalString type:(NSString*)typestr;
/**时间转时间戳*/
+ (NSString *)getTimestampFromTime:(NSString*)str;
@end

NS_ASSUME_NONNULL_END
