//
//  UITabBar+badge.h
//  YunDi_Student
//
//  Created by Chen on 2016/12/15.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TabbarItemNums 4.0    //tabbar的数量

@interface UITabBar (badge)


- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
