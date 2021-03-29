//
//  CarouselProgressIndicateView.m
//  Youxiake
//
//  Created by Rain on 2020/1/2.
//  Copyright © 2020 youxiake. All rights reserved.
//

#import "CarouselProgressIndicateView.h"

@interface CarouselProgressIndicateView ()
@property (nonatomic, strong) UIProgressView *currentProgressView;
@property (nonatomic, strong) NSMutableArray <UIProgressView *>*progressArr;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger currentDisplayIndex;
@end

@implementation CarouselProgressIndicateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.progressBgColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
//        [HexColor(0xFFFFFF) colorWithAlphaComponent:0.4];
        self.progressTintColor = [UIColor whiteColor];
//        [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//        HexColor(0xffffff);
        self.indicateWidth = 40;
        self.indicateSpace = 10;
        self.durationTime = 3;
        self.currentDisplayIndex = 0;
        self.progressArr = @[].mutableCopy;
    }
    return self;
}


- (void)setIndicateSpace:(CGFloat)indicateSpace {
    _indicateSpace = indicateSpace;
}

- (void)setDurationTime:(CGFloat)durationTime {
    _durationTime = durationTime;
}

- (void)setProgressBgColor:(UIColor *)progressBgColor {
    _progressBgColor = progressBgColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
}

- (void)setIndicateWidth:(CGFloat)indicateWidth {
    _indicateWidth = indicateWidth;
}

- (void)setIndicateNum:(NSInteger)indicateNum {
    _indicateNum = indicateNum;
    if ((self.indicateWidth * indicateNum + (indicateNum - 1) * self.indicateSpace) > ([UIScreen mainScreen].bounds.size.width - CGRectGetMinX(self.frame)* 2)) {
        self.indicateWidth = (([UIScreen mainScreen].bounds.size.width - CGRectGetMinX(self.frame)* 2) - (indicateNum - 1) * self.indicateSpace) * 1.0 / indicateNum;
    }
    for (int i = 0; i < indicateNum; i++) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(i * (self.indicateWidth + self.indicateSpace), 0, self.indicateWidth, 2)];
        progressView.trackTintColor = self.progressBgColor;
        progressView.layer.cornerRadius = 1;
        progressView.clipsToBounds = YES;
        progressView.progressTintColor = self.progressTintColor;
//        progressView.progress = 0;
        
        if (i == 0) {
            self.currentProgressView = progressView;
        }
        [self addSubview:progressView];
        [self.progressArr addObject:progressView];
    }
     self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
     [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

                        
- (void)action {
    self.currentProgressView.progress += (1 / (_durationTime * 60.0));
    if (self.currentProgressView.progress >= 1.0) {
        self.currentProgressView.progress = 0;
        [self.displayLink setPaused:YES];
        self.currentDisplayIndex += 1;
        if (self.currentDisplayIndex >= self.progressArr.count) {
            self.currentDisplayIndex = 0;
        }
        
        if (self.currentDisplayItem) {
            self.currentDisplayItem(self.currentDisplayIndex);
        }
        self.currentProgressView = [self.progressArr objectAtIndex:self.currentDisplayIndex];
        
//        [self.progressArr yxk_objectAtIndex:self.currentDisplayIndex];
        [self.displayLink setPaused:NO];
    }
}

- (void)setDisplayIndex:(NSInteger)index {
    if (index != self.currentDisplayIndex && index <= (self.progressArr.count - 1)) {
        self.currentDisplayIndex = index;
        [self.displayLink setPaused:YES];
        self.currentProgressView.progress = 0;
        self.currentProgressView = [self.progressArr objectAtIndex:index];
//    yxk_objectAtIndex:index];
        [self.displayLink setPaused:NO];
    }
}

- (void)dealloc {
    [self.displayLink setPaused:YES];
    [self.displayLink invalidate];
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
