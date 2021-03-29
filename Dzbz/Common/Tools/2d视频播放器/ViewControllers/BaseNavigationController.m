/*!
 @header BaseNavigationController.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/19
 
 @version 1.00 16/1/19 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor redColor];
    //返回按钮颜色
//    UIImage *backButtonImage = [[UIImage imageNamed:@"navigator_btn_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    self.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17.0],NSFontAttributeName ,nil];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>=1) {
           viewController.hidesBottomBarWhenPushed = YES;
       }
    
    [super pushViewController:viewController animated:animated];
    
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        // 修改tabBra的frame
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}
-(BOOL)prefersStatusBarHidden{
    if(self.topViewController.prefersStatusBarHidden){
        return self.topViewController.prefersStatusBarHidden;
    }
    return NO;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    if(self.topViewController.preferredStatusBarUpdateAnimation){
           return self.topViewController.preferredStatusBarUpdateAnimation;
       }
    return UIStatusBarAnimationNone;
}
-(BOOL)shouldAutorotate{
    if(self.topViewController.shouldAutorotate){
        return self.topViewController.shouldAutorotate;
    }
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if(self.topViewController.supportedInterfaceOrientations){
        return self.topViewController.supportedInterfaceOrientations;
    }
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    if(self.topViewController.preferredInterfaceOrientationForPresentation){
        return self.topViewController.preferredInterfaceOrientationForPresentation;
    }
    return UIInterfaceOrientationPortrait;
}
@end
