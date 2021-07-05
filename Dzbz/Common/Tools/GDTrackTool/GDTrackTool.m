//
//  GDTrackTool.m
//  GDTrackToolDemo
//
//  Created by 黄彬彬 on 2019/7/16.
//  Copyright © 2019 黄彬彬. All rights reserved.
//

#import "GDTrackTool.h"
#import <UMCommon/MobClick.h>
#import <UMCommon/UMCommon.h>

#define UMENG_KEY @"59db18ae766613673b00002e"

@implementation GDTrackTool

+ (void)configure {
    [UMConfigure initWithAppkey:UMENG_KEY channel:nil];
//    UMConfigInstance.appKey = UMENG_KEY;
//    UMConfigInstance.eSType = E_UM_NORMAL;
//    UMConfigInstance.ePolicy = 0;
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    [MobClick setVersion:currentVersion.integerValue];
//    [MobClick setAppVersion:currentVersion];
//    [MobClick startWithConfigure:UMConfigInstance];

#ifdef DEBUG
//    [MobClick setLogEnabled:YES];
      [UMConfigure setLogEnabled:YES];

//    [MobClick setCrashReportEnabled:NO];
#endif
}

+(void)beginLogPageID:(NSString *)pageID {
    [MobClick beginLogPageView:pageID];
    NSLog(@"进入页面-------->%@", pageID);
}

+(void)endLogPageID:(NSString *)pageID {
    [MobClick endLogPageView:pageID];
    NSLog(@"离开页面-------->%@", pageID);
}

+(void)logEvent:(NSString*)eventId {
//    [MobClick event:eventId];、
    NSLog(@"事件点击-------->%@", eventId);
}

@end
