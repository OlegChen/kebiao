//
//  UIScrollView+TouchEvent.m
//  YunDi_Student
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import "UIScrollView+TouchEvent.h"

@implementation UIScrollView (TouchEvent)

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    // 3.从后往前遍历自己的子控件
//    NSInteger count = self.subviews.count;
//    for (NSInteger i = count - 1; i >= 0; i--) {
//        UIView *childView = self.subviews[i];
//        // 把当前控件上的坐标系转换成子控件上的坐标系
//        CGPoint childP = [self convertPoint:point toView:childView];
//        UIView *fitView = [childView hitTest:childP withEvent:event];
//        if (fitView) { // 寻找到最合适的view
//            return fitView;
//        }
//    }
//    // 循环结束,表示没有比自己更合适的view
//    return self;
//}


- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    // If not dragging, send event to next responder
    if (!self.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}

@end

