////
////  ImagePickerManger.m
////  FengYunDiYin_Student
////
////  Created by Chen on 16/8/6.
////  Copyright © 2016年 Chen. All rights reserved.
////
//#import "ImagePickerManger.h"
//
//#import "QBImagePickerController.h"
//
//#import "Navigation.h"
//
//
//#import<AVFoundation/AVCaptureDevice.h>
//
//#import <AVFoundation/AVMediaFormat.h>
//
//#import<AssetsLibrary/AssetsLibrary.h>
//
//#import<CoreLocation/CoreLocation.h>
//
//
//@interface ImagePickerManger ()<QBImagePickerControllerDelegate>
//
//
//@property (nonatomic ,strong )  QBImagePickerController * ImagePickvc;
//
//
//@property (copy, nonatomic) void(^completion)(NSArray *ImageArray, BOOL sendSucess); //sendSucess: no 未选择图片或无数据
//
//@property (nonatomic ,assign) NSInteger LimitNum;
//
//@property (nonatomic ,strong) UIViewController  *vc;
//
//
//
//@end
//
//
//@implementation ImagePickerManger
//
//+ (instancetype)Manager{
//    static ImagePickerManger *ImagePicker_manager = nil;
//    static dispatch_once_t pred;
//    dispatch_once(&pred, ^{
//        ImagePicker_manager = [[self alloc] init];
//    });
//    return ImagePicker_manager;
//}
//
//
//+ (instancetype)handelVideoPickerWithLimitNum:(NSInteger)limitNum withController:(UIViewController *)vc WithContent:(void(^)(NSArray *assets, BOOL sendSucess)) block{
//
//
//    ImagePickerManger *manager = [self Manager];
//
//    manager.vc = vc;
//    manager.LimitNum = limitNum;
//    manager.completion = block;
//
//
//    [manager showPickervcWithType:QBImagePickerMediaTypeVideo];
//
//
//    return manager;
//
//}
//
//
//+ (instancetype)handelImagePickerWithLimitNum:(NSInteger)limitNum withController:(UIViewController *)vc WithContent:(void(^)(NSArray *assets, BOOL sendSucess)) block{
//
//    ImagePickerManger *manager = [self Manager];
//
//    manager.vc = vc;
//    manager.LimitNum = limitNum;
//    manager.completion = block;
//
//
//    [manager showPickervcWithType:QBImagePickerMediaTypeImage];
//
//
//    return manager;
//
//}
//
//- (void)showPickervcWithType:(QBImagePickerMediaType)type{
//
//    _ImagePickvc.mediaType = type;
//    _ImagePickvc.delegate = self;
//    _ImagePickvc.allowsMultipleSelection = YES;
//    _ImagePickvc.showsNumberOfSelectedAssets = YES;
//    _ImagePickvc.maximumNumberOfSelection = self.LimitNum;
//    //Navigation *navigationController = [[Navigation alloc] initWithRootViewController:_ImagePickvc];
//    [self.vc presentViewController:_ImagePickvc animated:YES completion:NULL];
//
//
//}
//
//- (instancetype)init{
//
//    self = [super init];
//
//    if (self) {
//
//        //        相册  < 判断 相册可用 >
////        if (![Helper checkPhotoLibraryAuthorizationStatus]) {
////            return;
////        }
//        self.ImagePickvc = [[QBImagePickerController alloc] init];
//
//    }
//
//    return self;
//}
//
////- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset{
////
////    [self.vc dismissViewControllerAnimated:YES completion:NULL];
////
////}
//
//- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
//
//
//    if (assets.count > 0) {
//
//        self.completion(assets , YES);
//
//    }else{
//
//        self.completion(assets , NO);
//
//    }
//
//
//    [self.vc dismissViewControllerAnimated:YES completion:NULL];
//
//
//}
//
//- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
//
//    [self.vc dismissViewControllerAnimated:YES completion:NULL];
//
//}
//
////- (void)getImageFromPHAsset:(PHAsset *)asset Complete:(Result)result {
////    __block NSData *data;
////    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
////    if (asset.mediaType == PHAssetMediaTypeImage) {
////        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
////        options.version = PHImageRequestOptionsVersionCurrent;
////        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
////        options.synchronous = YES;
////        [[PHImageManager defaultManager] requestImageDataForAsset:asset
////                                                          options:options
////                                                    resultHandler:
////         ^(NSData *imageData,
////           NSString *dataUTI,
////           UIImageOrientation orientation,
////           NSDictionary *info) {
////             data = [NSData dataWithData:imageData];
////         }];
////    }
////
////    if (result) {
////        if (data.length <= 0) {
////            result(nil, nil);
////        } else {
////            result(data, resource.originalFilename);
////        }
////    }
////}
////
//
//
//
//+ (BOOL)isHaveAlbumAuthorWithFirstAgreeBlock:(void (^)())block rejectAgree:(void(^)())rejectBlock{
//
//    //相册权限
//
//    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
//
//    if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
//
//        //无权限 引导去开启
//
//        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"请到设置中打开相册权限" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//
//            if (buttonIndex == 1) {
//
//                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//
//                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//
//                        [[UIApplication sharedApplication] openURL:url];
//
//                    }
//
//            }
//
//            rejectBlock();
//
//        }];
//
//        return NO;
//
//    }else if (author == kCLAuthorizationStatusNotDetermined){
//
//        //未授权
//
//        ALAssetsLibrary * assetsLibrary = [[ALAssetsLibrary alloc]init];
//        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//            if (*stop) {
//                                    NSLog(@"-----好");
//                block();
//
//            }
//            *stop = true;
//        } failureBlock:^(NSError *error) {
//                            NSLog(@"----不允许");
//
//            rejectBlock();
//        }];
//
//
//    }else{
//
//
//        return YES;
//    }
//
//    return NO;
//
//}
//
//
//
//+ (void)isHaveAlbumAuthorCamera:(void (^)(BOOL isAgree))block microphone:(void (^)(BOOL isagree))microBlock{
//
//
//
//
//
//    // 判断是否有摄像头权限
//    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//
//    if (authorizationStatus == AVAuthorizationStatusNotDetermined) //
//    {
//
//        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (granted)
//                {
//                    // 用户授权
//                    block(YES);
//                }
//                else
//                {
//                    // 用户拒绝授权
//
//                    block(NO);
//
//                }
//            });
//        }];
//
//        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {//麦克风权限
//            if (granted) {
//                NSLog(@"Authorized");
//                microBlock(YES);
//
//            }else{
//                NSLog(@"Denied or Restricted");
//
//                microBlock(NO);
//            }
//        }];
//
//
//        return;
//    }else if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
//
////        [UIAlertView bk_showAlertViewWithTitle:nil message:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头" cancelButtonTitle:@"确定" otherButtonTitles:@[] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
////
////        }];
//
//        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"请到设置中打开摄像头权限" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//
//            if (buttonIndex == 1) {
//
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//
//                    [[UIApplication sharedApplication] openURL:url];
//
//                }
//            }
//
//        }];
//
//
//        return;
//    }
//
//    // 开启麦克风权限
//    AVAuthorizationStatus  audioStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
//
//    if (audioStatus == AVAuthorizationStatusRestricted||audioStatus == AVAuthorizationStatusDenied) //
//    {
//
////        [UIAlertView bk_showAlertViewWithTitle:nil message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风" cancelButtonTitle:@"确定" otherButtonTitles:@[] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
////
////        }];
//
//        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"请到设置中打开麦克风权限，否则会导致录制视频没有声音！" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//
//            if (buttonIndex == 1) {
//
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//
//                    [[UIApplication sharedApplication] openURL:url];
//
//                }
//
//            }
//
//
//        }];
//
//        return;
//
//    }
//
//
//
//
//}
//
//
//
//@end

