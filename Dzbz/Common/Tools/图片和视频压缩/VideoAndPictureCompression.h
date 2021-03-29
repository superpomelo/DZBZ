//
//  VideoAndPictureCompression.h
//  Beanrobot_V1.0
//
//  Created by superpomelo on 2018/8/23.
//  Copyright © 2018年 superpomelo. All rights reserved.
//  压缩视频,图片

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface VideoAndPictureCompression : NSObject
/**裁  剪 */
+ (UIImage*)scaleToSize:(UIImage *)img size:(CGSize)size;

/** 压 缩 */
+ (NSData*)imageData:(UIImage *)myimage;
/**裁  剪 */
//+ (void)scaleToSize:(UIImage *)img size:(CGSize)size Sucess:(void (^)(UIImage*))sucessBlock;
/** 压 缩 */
//+ (void)imageData:(UIImage *)myimage  Sucess:(void (^)( NSData *))sucessBlock;
/**压缩视频*/
+ (void)compression:(NSURL*)videoUrl SuccessBlock:(void (^)( NSURL *))sucessBlock;
@end
