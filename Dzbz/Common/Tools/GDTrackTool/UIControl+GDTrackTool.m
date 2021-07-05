//
//  UIControl+GDTrackTool.m
//  GDTrackToolDemo
//
//  Created by 黄彬彬 on 2019/7/16.
//  Copyright © 2019 黄彬彬. All rights reserved.
//

#import "UIControl+GDTrackTool.h"
#import "GDTrackTool.h"
#import <objc/runtime.h>

@implementation UIControl (GDTrackTool)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(gd_sendAction:to:forEvent:);
        [self swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)gd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    //插入埋点代码
    [self trackAction:action to:target forEvent:event];
    //回归原方法
    [self gd_sendAction:action to:target forEvent:event];
}

- (void)trackAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSString *eventID = nil;
    //只统计触摸结束时
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
        eventID = [NSString stringWithFormat:@"%@_%@_touch", targetName, actionString];
        [GDTrackTool logEvent:eventID];
    }
}


@end
