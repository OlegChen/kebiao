//
//  UINavigationController+customProperty.h
//  YunDi_Student
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (customProperty)

//是否自定义隐藏tabbar
@property (nonatomic, assign) BOOL isCustomHidenTabbar;



- (void)showTabBar:(UITabBarController *) tabbarcontroller;

- (void)hideTabBar:(UITabBarController *) tabbarcontroller;

@end
