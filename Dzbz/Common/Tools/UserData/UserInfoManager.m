//
//  UserInfoManager.m
//  
//
//  Created by superpomelo on 2018/9/13.
//  Copyright © 2018年 XQ. All rights reserved.
//


#define Token @"token"
#define Uid @"uid"
#define LoginStatus @"loginstatus"
#define GuideStatus @"guidestatus"
#define AFNetworkReachabilityU @"afnreachability"


#import "UserInfoManager.h"

@implementation UserInfoManager





/**用户token（存）*/
+ (void)setToken:(NSString*)token{
    [UserDefault setObject:token forKey:Token];
    [UserDefault synchronize];
}

/**用户token（取）*/
+ (NSString*)getToken{
    return [UserDefault objectForKey:Token];
}
/**用户id（存）*/
+ (void)setUid:(NSString*)uid{
    [UserDefault setObject:uid forKey:Uid];
    [UserDefault synchronize];
}
/**用户id（取）*/
+ (NSString*)getUid{
    return [UserDefault objectForKey:Uid];

}
/**网络状态（存）*/
+ (void)setAFNetworkReachabilityStatus:(NSString*)status{
    [UserDefault setObject:status forKey:AFNetworkReachabilityU];
    [UserDefault synchronize];
}
/**网络状态（取）*/
+ (NSString*)getAFNetworkReachabilityStatus{
    return [UserDefault objectForKey:AFNetworkReachabilityU];

}

/**登录状态（存）*/
+ (void)setLoginStatus:(NSString*)status{
    [UserDefault setObject:status forKey:LoginStatus];
    [UserDefault synchronize];
}

/**登录状态（取）*/
+ (NSString*)getLoginStatus{
    return [UserDefault objectForKey:LoginStatus];
}
/**引导页标记（存）*/
+ (void)setGuideStatus:(NSString*)Guide{
    [UserDefault setObject:Guide forKey:GuideStatus];
    [UserDefault synchronize];
}
/**引导页标记（取）*/
+ (NSString*)getGuide{
     return [UserDefault objectForKey:GuideStatus];
}

/**删除保存的所有数据*/
+ (void)RemoveAllValue{
     [UserDefault removeObjectForKey:LoginStatus];
     [UserDefault removeObjectForKey:Uid];
     [UserDefault removeObjectForKey:Token];
}
@end
