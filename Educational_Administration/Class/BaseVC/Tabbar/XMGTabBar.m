//
//  XMGTabBar.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTabBar.h"
#import "UIView+FP.h"

#import "UIBadgeView.h"
#import "BarButton.h"
@interface XMGTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

/** 上一次点击的按钮 */ 
@property (nonatomic, weak) UIControl *previousClickedTabBarButton;
@end

@implementation XMGTabBar

//- (UIButton *)plusButton
//{
//    if (_plusButton == nil) {
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:[UIImage imageNamed:@"录制icon"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"录制icon"] forState:UIControlStateHighlighted];
//        [btn addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [btn sizeToFit];
//        [self addSubview:btn];
//
//        _plusButton = btn;
//    }
//    return _plusButton;
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 跳转tabBarButton位置
    NSInteger count = self.items.count;
    
    CGFloat btnW = self.width / (count); //中间加入按钮的话 （count + 1）
    CGFloat btnH = 47;
    CGFloat x = 0;
    int i = 0;
    // 私有类:打印出来有个类,但是敲出来没有,说明这个类是系统私有类
    // 遍历子控件 调整布局
    for (UIControl *tabBarButton in self.subviews) {

        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 设置previousClickedTabBarButton默认值为最前面的按钮
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            
//            if (i == 2) {
//                i += 1;
//            }
            
            for (UIView *sTabBarItem in tabBarButton.subviews) {
                
                if ([sTabBarItem isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    sTabBarItem.frame = CGRectMake(0, 0, 20, 20);
                }
                else if ([sTabBarItem isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
                    
                    UILabel *l = (UILabel *)sTabBarItem;
                    l.font = [UIFont systemFontOfSize:11];
                    l.textAlignment = NSTextAlignmentCenter;
                }
                
            }
            
            x = i * btnW;
            
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            
            i++;

            
            // UIControlEventTouchDownRepeat : 在短时间内连续点击按钮
            
            // 监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    // 添加视频按钮
//    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.3);
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
//    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
//    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
//    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
//    if (self.isHidden == NO) {
//
//        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
//        CGPoint newP = [self convertPoint:point toView:self.plusButton];
//
//        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
//        if ( [self.plusButton pointInside:newP withEvent:event]) {
//            return self.plusButton;
//        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
//            return [super hitTest:point withEvent:event];
//        }
//    }
//    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
//        return [super hitTest:point withEvent:event];
//    }
//}


//- (void)plusButtonClick{
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:midBtnClik object:nil];
//    
//}



/**
 *  tabBarButton的点击
 */
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    if (self.previousClickedTabBarButton == tabBarButton) {
        // 发出通知，告知外界tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil];
    }
    
    self.previousClickedTabBarButton = tabBarButton;
}

@end
