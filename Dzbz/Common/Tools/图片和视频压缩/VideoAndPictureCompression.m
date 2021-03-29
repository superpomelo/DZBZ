//
//  VideoAndPictureCompression.m
//  Beanrobot_V1.0
//
//  Created by superpomelo on 2018/8/23.
//  Copyright © 2018年 superpomelo. All rights reserved.
//  视频和图片压缩

#import "VideoAndPictureCompression.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@implementation VideoAndPictureCompression
#pragma mark - 裁剪
/**裁  剪 */
+ (UIImage*)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    
    NSData *imageDataPNG = UIImagePNGRepresentation(scaledImage);
    NSData *imageDataJPG = UIImageJPEGRepresentation(scaledImage, 1);
    
    NSLog(@"PNG=%f----JPG=%f",imageDataPNG.length/1024.f,imageDataJPG.length/1024.f);
    //    CGFloat  kb =   data.lenth / 1024;
    
    //    [self imageData:scaledImage];
   return  scaledImage;
    
}

/** 压缩 */
+ (NSData*)imageData:(UIImage *)myimage{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024){//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
            
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
            
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
            
        }
    }
    NSLog(@"jPg=%f",data.length/1024.f);
    
    return data;
    
}
///**裁  剪 */
//+ (void)scaleToSize:(UIImage *)img size:(CGSize)size Sucess:(void (^)(UIImage*))sucessBlock{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    //返回新的改变大小后的图片
//
//    NSData *imageDataPNG = UIImagePNGRepresentation(scaledImage);
//    NSData *imageDataJPG = UIImageJPEGRepresentation(scaledImage, 1);
//
//    NSLog(@"PNG=%f----JPG=%f",imageDataPNG.length/1024.f,imageDataJPG.length/1024.f);
//    //    CGFloat  kb =   data.lenth / 1024;
//
//    //    [self imageData:scaledImage];
//    sucessBlock(scaledImage);
//
//}
/** 压缩 */
//+ (void)imageData:(UIImage *)myimage  Sucess:(void (^)( NSData *))sucessBlock
//{
//    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
//    if (data.length>100*1024) {
//        if (data.length>1024*1024){//1M以及以上
//            data=UIImageJPEGRepresentation(myimage, 0.1);
//
//        }else if (data.length>512*1024) {//0.5M-1M
//            data=UIImageJPEGRepresentation(myimage, 0.5);
//
//        }else if (data.length>200*1024) {//0.25M-0.5M
//            data=UIImageJPEGRepresentation(myimage, 0.9);
//
//        }
//    }
//    NSLog(@"jPg=%f",data.length/1024.f);
//
//    sucessBlock(data);
//
//}
/**压缩视频*/
+ (void)compression:(NSURL*)videoUrl SuccessBlock:(void (^)( NSURL *))sucessBlock{
//    NSLog(@"压缩前大小 %f MB",[self fileSize:videoUrl]);
    // 创建AVAsset对象
    AVAsset* asset = [AVAsset assetWithURL:videoUrl];
    /*
     创建AVAssetExportSession对象
     压缩的质量
     AVAssetExportPresetLowQuality 最low的画质最好不要选择实在是看不清楚
     AVAssetExportPresetMediumQuality 使用到压缩的话都说用这个
     AVAssetExportPresetHighestQuality 最清晰的画质
     */
AVAssetExportSession * session = [[AVAssetExportSession alloc]
                                  initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
//优化网络
session.shouldOptimizeForNetworkUse = YES;
//转换后的格式
//拼接输出文件路径 为了防止同名 可以根据日期拼接名字 或者对名字进行MD5加密
NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
                  stringByAppendingPathComponent:@"hello.mp4"];
//判断文件是否存在，如果已经存在删除
[[NSFileManager defaultManager]removeItemAtPath:path error:nil];
//设置输出路径
session.outputURL = [NSURL fileURLWithPath:path];
//设置输出类型 这里可以更改输出的类型 具体可以看文档描述
session.outputFileType = AVFileTypeMPEG4;
[session exportAsynchronouslyWithCompletionHandler:^{
    NSLog(@"%@",[NSThread currentThread]);
    //压缩完成
    if(session.status==AVAssetExportSessionStatusCompleted) {
        //在主线程中刷新UI界面，弹出控制器通知用户压缩完成
        dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"导出完成");
        NSURL * CompressURL;
        CompressURL = session.outputURL;
        sucessBlock(CompressURL);

//        NSLog(@"压缩完毕,压缩后大小 %f MB",[self fileSize:CompressURL]);
    });
}
 }];
}

//计算压缩大小
+ (CGFloat)fileSize:(NSURL *)path
{
    return [[NSData dataWithContentsOfURL:path] length]/1024.00 /1024.00;
}
@end
