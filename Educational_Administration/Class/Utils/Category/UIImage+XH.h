//
//  UIImage+XH.h
//  新浪微博
//
//  Created by mac on 14-10-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XH)

//图片的适配，根据传入的图片名称创建适配好之后的图片

+ (UIImage *)imageWithName:(NSString *)imageName;


//根据图片名称创建一张拉伸不变形的tupian
+ (instancetype)resizableImageWithName:(NSString *)imageName;


//创建拉伸不变形的图片
// leftRatio  左边不拉伸比例
//  @param rigthRatio 顶部不拉伸比例

+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio;

- (UIImage*)transformWidth:(CGFloat)width

                    height:(CGFloat)height;

//相机(摄像头)获取到的图片自动旋转90度解决办法
- (UIImage *)fixOrientation:(UIImage *)aImage;

//根据颜色返回图片
+(UIImage*) imageWithColor:(UIColor*)color;
@end
