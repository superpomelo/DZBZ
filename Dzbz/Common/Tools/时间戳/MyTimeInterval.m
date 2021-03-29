//
//  MyTimeInterval.m
//  labor
//
//  Created by 狍子 on 2020/9/9.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "MyTimeInterval.h"

@implementation MyTimeInterval


/**获取当前时间戳*/
+ (NSString *)getNowDateSJC {
    
    NSDate* dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInt=[dateNow timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", timeInt];
    
    return timeString;
}

/**时间戳转时间*/
+ (NSString*)IntervalStringToDateString:(NSString*)IntervalString{
    // iOS 生成的时间戳是10位
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[IntervalString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
/**时间戳转时间*/
+ (NSString*)IntervalStringToDateString2:(NSString*)IntervalString{
    // iOS 生成的时间戳是10位
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM/dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[IntervalString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
/**获取今天之后的7天<含今天>*/
+ (NSMutableArray*)getsevenDays{
    NSMutableArray *IntervalArrayM = [NSMutableArray array];
    NSInteger nowtime = [[self getNowDateSJC] integerValue];
    for (int i = 0; i<7; i++) {
        if (i==0) {
            [IntervalArrayM addObject:@"今天"];
        }else if (i==1){
            [IntervalArrayM addObject:@"明天"];
        }else{
            NSInteger  nextTime = nowtime + i*86400;
            [IntervalArrayM addObject:[self IntervalStringToDateString2:[NSString stringWithFormat:@"%ld",nextTime]]];
        }
    }
    return IntervalArrayM;
}

#pragma mark --- 将时间转换成时间戳

+ (NSString *)getTimestampFromTime:(NSString*)str{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要
//例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.

//例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?

//他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了

NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

[formatter setTimeZone:timeZone];

//NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSDate *date = [formatter dateFromString:str];
NSString *nowtimeStr = [formatter stringFromDate:date];//----------将nsdate按formatter格式转成nsstring

NSLog(@"%@", nowtimeStr);

// 时间转时间戳的方法:

NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];

NSLog(@"timeSp:%@",timeSp);//时间戳的值

return timeSp;

}
/**时间转成需要的时间*/
+ (NSString*)IntervalStringToIneedDateString:(NSString*)IntervalString type:(NSString*)typestr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:typestr];
    // 毫秒值转化为秒

    NSDate* date = [formatter dateFromString:IntervalString];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}
@end
