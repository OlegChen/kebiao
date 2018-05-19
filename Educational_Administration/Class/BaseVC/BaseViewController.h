//
//  BaseViewController.h
//  FengYunDi_Student
//
//  Created by Chen on 16/7/26.
//  Copyright © 2016年 Chen. All rights reserved.
//

typedef void (^isHaveMessage) (BOOL ishabe);

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (BOOL)islogined;

/**
 *  压缩图片
 *
 *  @param image       需要压缩的图片
 *  @param fImageBytes 希望压缩后的大小(以KB为单位)
 *
 *  @return 压缩后的图片
 */
- (void)compressedImageFiles:(UIImage *)image
                     imageKB:(CGFloat)fImageKBytes
                  imageBlock:(void(^)(UIImage *image))block;

//有无消息
+ (void)isHaveMessageWithResult:(isHaveMessage)isHave;

@end
