//
//  IsIphoneX.m
//  PtaxiMaster
//
//  Created by 狍子 on 2019/4/16.
//  Copyright © 2019 yzcx. All rights reserved.
//

#import "IsIphoneX.h"
#import <objc/runtime.h>
#import "sys/utsname.h"

@implementation IsIphoneX
+ (BOOL)isIphoneX {
    // 根据安全区域判断
    if (@available(iOS 11.0, *)) {
        CGFloat height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        return (height > 0);
    } else {
        return NO;
    }
}
+ (CGFloat)navBarBottom {
    return [self isIphoneX] ? 88 : 64;
}
+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}
@end
