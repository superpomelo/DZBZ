//
//  CarouselProgressIndicateView.h
//  Youxiake
//
//  Created by Rain on 2020/1/2.
//  Copyright © 2020 youxiake. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarouselProgressIndicateView : UIView
@property (nonatomic, strong) UIColor *progressBgColor;
@property (nonatomic, strong) UIColor *progressTintColor;
@property (nonatomic, assign) NSInteger indicateNum;
@property (nonatomic, assign) CGFloat indicateWidth;
@property (nonatomic, assign) CGFloat indicateSpace;
@property (nonatomic, assign) CGFloat durationTime;
@property (nonatomic, copy) void(^currentDisplayItem)(NSInteger index);
- (void)setDisplayIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
