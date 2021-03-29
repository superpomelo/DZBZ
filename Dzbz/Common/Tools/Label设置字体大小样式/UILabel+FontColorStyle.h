//
//  UILabel+FontColorStyle.h
//  labor
//
//  Created by 狍子 on 2020/11/25.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FontColorStyle)
/**<自定义字体专用>返回NSAttributedString 传入字体大小font，字体颜色color，字体样式zitistyle（打入的自定义字体）*/
+ (NSMutableAttributedString*)getABTbody:(NSString*)body font:(CGFloat)font color:(UIColor*)color zitistyle:(NSString*)zitistyle lineSpacing:(NSInteger)spac;
/**<系统字体专用>返回NSAttributedString 传入字体大小size，<普通字或者加粗字fontInteger 0-普通，1-加粗> 字体颜色color，字体样式zitistyle（打入的自定义字体）*/
+ (NSMutableAttributedString*)getSystemABTbody:(NSString*)body fontInteger:(NSInteger)fontInteger Alignment:(NSTextAlignment)alignment Size:(CGFloat)size color:(UIColor*)color lineSpacing:(NSInteger)spac;
@end

NS_ASSUME_NONNULL_END
