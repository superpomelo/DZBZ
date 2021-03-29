//
//  UIButton+fontColorStyle.m
//  labor
//
//  Created by 狍子 on 2020/11/25.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "UIButton+fontColorStyle.h"

@implementation UIButton (fontColorStyle)
/**<自定义字体专用>返回NSAttributedString 传入字体大小font，字体颜色color，字体样式zitistyle（打入的自定义字体）*/
+ (NSMutableAttributedString*)getABTbody:(NSString*)body font:(CGFloat)font color:(UIColor*)color zitistyle:(NSString*)zitistyle{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:body attributes:@{NSFontAttributeName: [UIFont fontWithName:zitistyle size: font],NSForegroundColorAttributeName:color}];
    return attributedString;
}

/**<系统字体专用>返回NSAttributedString 传入字体大小size，<普通字或者加粗字fontInteger 0-普通，1-加粗> 字体颜色color，字体样式zitistyle（打入的自定义字体）*/
+ (NSMutableAttributedString*)getSystemABTbody:(NSString*)body fontInteger:(NSInteger)fontInteger Size:(CGFloat)size color:(UIColor*)color lineSpacing:(NSInteger)spac{
    UIFont *font;
    if (fontInteger==0) {
        font = [UIFont systemFontOfSize:size];
    }else if (fontInteger==1) {
        font = [UIFont boldSystemFontOfSize:size];
    }
//    NSMutableAttributedString *attributedString;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:body attributes:@{NSKernAttributeName:@(0.0),NSFontAttributeName: font,NSForegroundColorAttributeName:color}];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spac];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [body length])];
    return attributedString;
}
@end
