//
//  UINavigationController+customProperty.m
//  YunDi_Student
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import "UINavigationController+customProperty.h"
#import <objc/runtime.h>

static void *isCustomHidenTabbarKey = &isCustomHidenTabbarKey;

@implementation UINavigationController (customProperty)

-(void)setIsCustomHidenTabbar:(BOOL)isCustomHidenTabbar {
    
    objc_setAssociatedObject(self, & isCustomHidenTabbarKey, @(isCustomHidenTabbar), OBJC_ASSOCIATION_COPY);
}

-(BOOL)isCustomHidenTabbar {
    
    return [objc_getAssociatedObject(self, &isCustomHidenTabbarKey) boolValue];
}



//**************

// Method implementations
- (void)hideTabBar:(UITabBarController *) tabbarcontroller
{
    // 隐藏tabbar
    
    [UIView animateWithDuration:0.2 animations:^{
        for(UIView *view in tabbarcontroller.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                [view setFrame:CGRectMake(view.frame.origin.x,
                                          view.frame.origin.y + (Is_iPhoneX ? 120 : 80),
                                          view.frame.size.width,
                                          view.frame.size.height)];
            }
        }
        
    } completion:^(BOOL finished) {
        
    }];

}

- (void)showTabBar:(UITabBarController *) tabbarcontroller
{
    // 显示tabbar
    [UIView animateWithDuration:0.2 animations:^{
        for(UIView *view in tabbarcontroller.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                [view setFrame:CGRectMake(view.frame.origin.x,
                                          view.frame.origin.y - (Is_iPhoneX ? 120 : 80),
                                          view.frame.size.width,
                                          view.frame.size.height)];
            }
//            else
//            {
//                [view setFrame:CGRectMake(view.frame.origin.x,
//                                          view.frame.origin.y,
//                                          view.frame.size.width,
//                                          view.frame.size.height - 80)];
//            }
        }
    }];
}


@end
