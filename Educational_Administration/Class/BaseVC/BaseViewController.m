////
////  BaseViewController.m
////  FengYunDi_Student
////
////  Created by Chen on 16/7/26.
////  Copyright © 2016年 Chen. All rights reserved.
////
//
//#import "BaseViewController.h"
//#import "LoginViewController.h"
//#import "Navigation.h"
//#import "UMMobClick/MobClick.h"
//
//#import "MyMessageBaseTypeModel.h"
//#import "MyMessageBaseReturnObjModel.h"
//
//@implementation BaseViewController
//
//
//- (void)viewDidLoad{
//
//#pragma  mark - 网络判断
//
//}
//
//
//
//
//#pragma mark - 页面统计
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:NSStringFromClass([self class])];//("PageOne"为页面名称，可自定义)
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:NSStringFromClass([self class])];
//}
//
//
//#pragma mark login判断
//
//- (BOOL)islogined{
//    
//    if ([UserCenter isLogin]) {
//        
//        return YES;
//        
//    }else{
//        
//        LoginViewController *vc = [[LoginViewController alloc]init];
//        Navigation *nvc=[[Navigation alloc]initWithRootViewController:vc];
//        
//        [self presentViewController:nvc animated:YES completion:^{
//            
//        }];
//        
//        return NO;
//        
//    }
//}
//
///**
// *  压缩图片
// *
// *  @param image       需要压缩的图片
// *  @param fImageBytes 希望压缩后的大小(以KB为单位)
// *
// *  @return 压缩后的图片
// */
//- (void)compressedImageFiles:(UIImage *)image
//                     imageKB:(CGFloat)fImageKBytes
//                  imageBlock:(void(^)(UIImage *image))block {
//    
//    __block UIImage *imageCope = image;
//    CGFloat fImageBytes = fImageKBytes * 1024;//需要压缩的字节Byte
//    
//    __block NSData *uploadImageData = nil;
//    
//    uploadImageData = UIImagePNGRepresentation(imageCope);
//    NSLog(@"图片压前缩成 %fKB",uploadImageData.length/1024.0);
//    CGSize size = imageCope.size;
//    CGFloat imageWidth = size.width;
//    CGFloat imageHeight = size.height;
//    
//    if (uploadImageData.length > fImageBytes && fImageBytes >0) {
//        
//        dispatch_async(dispatch_queue_create("CompressedImage", DISPATCH_QUEUE_SERIAL), ^{
//            
//            /* 宽高的比例 **/
//            CGFloat ratioOfWH = imageWidth/imageHeight;
//            /* 压缩率 **/
//            CGFloat compressionRatio = fImageBytes/uploadImageData.length;
//            /* 宽度或者高度的压缩率 **/
//            CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
//            
//            CGFloat dWidth   = imageWidth *widthOrHeightCompressionRatio;
//            CGFloat dHeight  = imageHeight*widthOrHeightCompressionRatio;
//            if (ratioOfWH >0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
//                dHeight = dWidth/ratioOfWH;
//            }else {
//                dWidth  = dHeight*ratioOfWH;
//            }
//            
//            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
//            uploadImageData = UIImagePNGRepresentation(imageCope);
//            
//            NSLog(@"当前的图片已经压缩成 %fKB",uploadImageData.length/1024.0);
//            //微调
//            NSInteger compressCount = 0;
//            /* 控制在 1M 以内**/
//            while (fabs(uploadImageData.length - fImageBytes) > 1024) {
//                /* 再次压缩的比例**/
//                CGFloat nextCompressionRatio = 0.9;
//                
//                if (uploadImageData.length > fImageBytes) {
//                    dWidth = dWidth*nextCompressionRatio;
//                    dHeight= dHeight*nextCompressionRatio;
//                }else {
//                    dWidth = dWidth/nextCompressionRatio;
//                    dHeight= dHeight/nextCompressionRatio;
//                }
//                
//                imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
//                uploadImageData = UIImagePNGRepresentation(imageCope);
//                
//                /*防止进入死循环**/
//                compressCount ++;
//                if (compressCount == 10) {
//                    break;
//                }
//                
//            }
//            
//            NSLog(@"图片已经压缩成 %fKB",uploadImageData.length/1024.0);
//            imageCope = [[UIImage alloc] initWithData:uploadImageData];
//            
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                block(imageCope);
//            });
//        });
//    }
//    else
//    {
//        block(imageCope);
//    }
//}
//
///* 根据 dWidth dHeight 返回一个新的image**/
//- (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(NSInteger)dWidth height:(NSInteger)dHeight{
//    
//    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
//    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
//    imageCope = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return imageCope;
//    
//}
//
//
//
////有无消息
//+ (void)isHaveMessageWithResult:(isHaveMessage)isHave{
//
//    if (![UserCenter isLogin]) {
//        
//        return;
//    }
//    
//    UserModel *model = [UserCenter curLoginUser];
//
//    [NetWork queryBasParaConfigListWithcustId:model.custId WaitAnimation:YES CompletionHandler:^(id object) {
//        
//        MyMessageBaseTypeModel *model = object;
//        
//        if (model.statusCode == 800) {
//            
//            BOOL a = NO;
//            
//            
//            for (MyMessageBaseReturnObjModel *m in model.returnObj) {
//                
//                if (m.status == 1) {
//                    
//                    a = YES;
//                }
//                
//            }
//            
//            if (isHave) isHave(a);
//
//            
//        }else{
//            
//             if (isHave) isHave(NO);
//            
//        }
//        
//    } errorHandler:^(id object) {
//        
//        if (isHave) isHave(NO);
//        
//    }];
//
//    
//    
//}
//
//@end

