//
//  FgradientView.m
//  BaseAppBao
//
//  Created by 狍子 on 2021/3/10.
//

#import "FgradientView.h"

@implementation FgradientView
/**rect  startColor-起始颜色  endColor-结束颜色  */
+ (UIView*)addGradientViewRect:(CGRect)rect startColor:(UIColor*)sColor endColor:(UIColor*)eColor startPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint locations:(NSArray*)points{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    gradientLayer.frame = rect;
    // @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor]
    gradientLayer.colors = @[(__bridge id)sColor.CGColor, (__bridge id)eColor.CGColor];
    gradientLayer.startPoint = sPoint;
    gradientLayer.endPoint = ePoint;
//    gradientLayer.locations = @[@(0),@(1.0f)];
    gradientLayer.locations = points;

    [view.layer addSublayer:gradientLayer];
    return view;
}
@end
