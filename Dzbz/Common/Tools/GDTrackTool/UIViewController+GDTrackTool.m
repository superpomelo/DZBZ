//
//  UIViewController+GDTrackTool.m
//  GDTrackToolDemo
//
//  Created by 黄彬彬 on 2019/7/16.
//  Copyright © 2019 黄彬彬. All rights reserved.
//

#import "UIViewController+GDTrackTool.h"
#import "GDTrackTool.h"
#import <objc/runtime.h>

@implementation UIViewController (GDTrackTool)

/*
 核心技术：面向AOP, runtime，分类
 
 load中交换方法，拿到方法选择器（启动时会加载所有类，此时就会调用+load方法）
 根据方法选择器和self类，拿到方法
 给originalSelector添加swizzledMethod
 给swizzledSelector换成originalMethod
 此时交换完成
 swizzledMethod中 1.注入埋点代码 2.调用系统方法
 */
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(gd_viewWillAppear:);
        [self swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzledSelector2 = @selector(gd_viewWillDisappear:);
        [self swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
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

- (void)gd_viewWillAppear:(BOOL)animated
{
    [self trackViewWillAppear];//插入埋点代码
    [self gd_viewWillAppear:animated];//调用系统方法
}

- (void)gd_viewWillDisappear:(BOOL)animated
{
    [self trackViewWillDisAppear];//插入埋点代码
    [self gd_viewWillDisappear:animated];//调用系统方法
}

- (void)trackViewWillAppear
{
    NSString *selfClassName = NSStringFromClass([self class]);
    NSString *pageID = [NSString stringWithFormat:@"%@_Enter", selfClassName];
    [GDTrackTool beginLogPageID:pageID];
//    [GDTrackTool logEvent:pageID];
}

- (void)trackViewWillDisAppear
{
    NSString *selfClassName = NSStringFromClass([self class]);
    NSString *pageID = [NSString stringWithFormat:@"%@_leave", selfClassName];
    [GDTrackTool endLogPageID:pageID];
}


@end
