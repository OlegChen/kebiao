//
//  NSString+Judgement.h
//  YunDi_Student
//
//  Created by Chen on 16/9/19.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Judgement)

- (BOOL)isPhoneNo;

- (BOOL)isChinaPhoneNo;
//密码
- (BOOL)isCustomPassword;

- (BOOL)isValidateName;
//数字 字母 + 中文
- (BOOL)isValidateEN_CN_No;

//日期转年龄
- (NSInteger)ageWithDateOfBirth;

//移除最后一个字符
+(NSString*) removeLastOneChar:(NSString*)origin;

//判断是否有空格
- (BOOL)isHaveblank;

- (BOOL)noChineseWord;

//判断emj表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//支付参数处理
+ (NSString *)DecodedStringWithPara:(NSString *)para WithAli:(BOOL)isAli;

//金钱加分号
+(NSString *)countNumAndChangeformat:(NSString *)string;

//字符串中空格 数量
+ (int)countOfBlankStrWith:(NSString *)string;
//字符串中#数量
+ (int)countOfArguementCharStrWith:(NSString *)string;

//话题 ## 变色
+ (NSMutableAttributedString *)setupTopicWithString:(NSString *)str;

@end
