//
//  FgradientView.h
//  BaseAppBao
//
//  Created by 狍子 on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FgradientView : NSObject
/**rect  startColor-起始颜色  endColor-结束颜色  */
+ (UIView*)addGradientViewRect:(CGRect)rect startColor:(UIColor*)sColor endColor:(UIColor*)eColor startPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint locations:(NSArray*)points;
@end

NS_ASSUME_NONNULL_END
