//
//  GDTrackTool.h
//  GDTrackToolDemo
//
//  Created by 黄彬彬 on 2019/7/16.
//  Copyright © 2019 黄彬彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDTrackTool : NSObject

+ (void)configure;
+ (void)beginLogPageID:(NSString *)pageID;
+ (void)endLogPageID:(NSString *)pageID;
+ (void)logEvent:(NSString*)eventId;

@end

NS_ASSUME_NONNULL_END
