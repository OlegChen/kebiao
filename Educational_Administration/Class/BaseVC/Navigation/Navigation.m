//
//  Navigation.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/27.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "Navigation.h"
#import "UIBarButtonItem+Item.h"
#import "UIImage+Common.h"

#import "UINavigationController+customProperty.h"




@implementation Navigation

+ (void)initialize
{
    // 设置导航栏的主题
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBarTintColor:[UIColor redColor]];
    
    [self setupItemTheme];
    
    [self setupNavTheme];
}

+ (void)setupNavTheme
{
    
    // 1.拿到导航条的主题对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"navBarBG"] forBarMetrics:UIBarMetricsDefault];
    
    //深颜色
    //    [navBar setBackgroundImage:[UIImage resizableImageWithName:@"navBarBG"]forBarMetrics:UIBarMetricsDefault];
    
//    [navBar setBarTintColor:[UIColor myColorWithHexString:@"#f2f2f2"]];

    navBar.tintColor = [UIColor myColorWithHexString:@"#333333"];
    
    
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor myColorWithHexString:@"#f2f2f2"]] forBarMetrics:0];
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        navBar.translucent = NO;
        
    }
    
    
    //navBar.alpha=1.0;
    
    // 4.设置标题的属性
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
  
    md[NSFontAttributeName] = [UIFont fontWithName:@"Arial" size:20];
    md[NSForegroundColorAttributeName] = [UIColor myColorWithHexString:@"333333"];
    [navBar setTitleTextAttributes:md];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效)
        
        
        UIBarButtonItem *leftButon = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"back_nav"] highImage:[UIImage imageNamed:@"back_nav"]  target:self action:@selector(popView) title:@" "];;

        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedButton.width = -5;
        viewController.navigationItem.leftBarButtonItems = @[fixedButton, leftButon];
        viewController.navigationItem.leftBarButtonItem = leftButon;

        
        if (self.childViewControllers.count == 1) {
            
            //首页隐藏 自己做
            if (self.tabBarController.selectedIndex == 1 && self.isCustomHidenTabbar){
                
                [self hideTabBar:self.tabBarController];
                
                
            }else{
            
                viewController.hidesBottomBarWhenPushed = YES;
                
                // 真正在跳转
                [super pushViewController:viewController animated:animated];
                // 修改tabBra的frame  iPhoneX push时tabbar跳动问题
                CGRect frame = self.tabBarController.tabBar.frame;
                frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
                self.tabBarController.tabBar.frame = frame;
                
                return;
                
            }
        }
    }
    
    // 真正在跳转
    [super pushViewController:viewController animated:animated];

}



+ (void)setupItemTheme
{
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    
    // 2.1设置文本属性
    // 2.1.1默认状态
    NSMutableDictionary *norMd = [NSMutableDictionary dictionary];
    norMd[NSForegroundColorAttributeName] = [UIColor myColorWithHexString:@"#555555"];
    norMd[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    norMd[NSShadowAttributeName] = shadow;
    [barItem setTitleTextAttributes:norMd forState:UIControlStateNormal];
    
    // 2.1.1高亮状态
    NSMutableDictionary *higMd = [NSMutableDictionary  dictionaryWithDictionary:norMd];
    higMd[NSForegroundColorAttributeName] = [UIColor myColorWithHexString:@"#555555"];
    [barItem setTitleTextAttributes:higMd forState:UIControlStateHighlighted];
    
    // 2.2设置不可用状态
    NSMutableDictionary *disMd = [NSMutableDictionary  dictionaryWithDictionary:norMd];
    disMd[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [barItem setTitleTextAttributes:disMd forState:UIControlStateDisabled];
    
    //    if (!iOS7) {
    //        // 3.设置按钮的背景图片
    //        [barItem setBackgroundImage:[UIImage imageWithNmae:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    }
}

- (void)popView
{
    // 回到上一级界面
    [self popViewControllerAnimated:YES];
    
}



@end
