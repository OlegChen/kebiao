//
//  MBProgressHUD+self.m
//  YunDi_Student
//
//  Created by Chen on 2016/12/23.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import "MBProgressHUD+self.h"

@implementation MBProgressHUD (self)

+ (void)showMsg:(NSString *)msg duration:(CGFloat)time
{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // 显示模式,改成customView,即显示自定义图片(mode设置,必须写在customView赋值之前)
    hud.mode = MBProgressHUDModeText;
    
    // 设置要显示 的自定义的图片
    // 显示的文字,比如:加载失败...加载中...
    hud.label.text = msg;
    hud.label.font = [UIFont systemFontOfSize:25];
    // 标志:必须为YES,才可以隐藏,  隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:time];
}

@end
