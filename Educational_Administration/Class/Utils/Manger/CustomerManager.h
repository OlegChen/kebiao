//
//  CustomerManager.h
//  YunDi_Student
//
//  Created by Chen on 16/9/21.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ClassResultModel.h"
//#import "UserModel.h"

typedef void(^cityContent)(NSString *cityName, NSString *cityCode);

//typedef void(^UpdateUserInfo)(UserModel *model);


@interface CustomerManager : NSObject

//是否第一次进入
+ (BOOL) isFirstEnterApp;

+ (NSString *)getUUID;

+ (NSString *)MD5WithStr:(NSString *)str;

+ (void)limtitLength:(UITextField *)textfield WithLenght:(int )length;

//时间差
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

//更新用户数据
//+ (void)updateUserData;
//+ (void)updateUserDataWithLoginModel:(UpdateUserInfo)userInfo;

//进入课程 判断是否需要去测评

+ (BOOL)CanEnterClassDetailWithVC:(BaseViewController *)vc WithClassCategoryId:(NSString *)categoryId WithClassLevel:(int)ClassLevel;

//保存城市数据
+ (void)saveSelectedCityWithName:(NSString *)cityName WithCityCode:(NSString *)CityCode;
+ (void)getSelectedCityWithCityContent:(cityContent)cityContent;

//记录不是第一次禁止 定位
+ (void)setUnLocationMark;
+ (BOOL)getUnlocationMark;

//客服电话
+ (void)CustomerServiceTel;


@end
