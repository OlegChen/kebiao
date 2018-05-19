//
//  NSString+Judgement.m
//  YunDi_Student
//
//  Created by Chen on 16/9/19.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import "NSString+Judgement.h"

@implementation NSString (Judgement)

//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo{

    
    if (self.length != 11)
        
    {
        
        return NO;
        
    }else{
        
//        /**
//         
//         * 移动号段正则表达式
//         
//         */
//        
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        
//        /**
//         
//         * 联通号段正则表达式
//         
//         */
//        
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        
//        /**
//         
//         * 电信号段正则表达式
//         
//         */
//        
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//        
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        
//        BOOL isMatch1 = [pred1 evaluateWithObject:self];
//        
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        
//        BOOL isMatch2 = [pred2 evaluateWithObject:self];
//        
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        
//        BOOL isMatch3 = [pred3 evaluateWithObject:self];
//        
//        
//        
//        if (isMatch1 || isMatch2 || isMatch3) {
//            
//            return YES;
//            
//        }else{
//            
//            return NO;
//            
//        }
        
        return YES;
        
    }
}

- (BOOL)isChinaPhoneNo{

    NSString * phoneRegex = @"^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];

}

//姓名(中文和字母)
- (BOOL)isValidateName
{
    NSString * regex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate * namaPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [namaPredicate evaluateWithObject:self];
}

//姓名(中文和字母 + 数字)
- (BOOL)isValidateEN_CN_No
{
    NSString * regex = @"^[\u4E00-\u9FA5A-Za-z0-9]+$";
    NSPredicate * namaPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [namaPredicate evaluateWithObject:self];
}


//密码
- (BOOL)isCustomPassword{
    

    if ( 6 <= self.length &&  self.length <= 20 ) {
        
        return YES;
        
    }else{
        
        return NO;
    
    }
}

- (BOOL)noChineseWord{
    
    //不包含中文 返回yes
    
    NSString * regex = @"^[^\u4e00-\u9fa5]{0,}$";
    NSPredicate * namaPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isNoCn = [namaPredicate evaluateWithObject:self];
    
    return isNoCn;
}


- (NSInteger)ageWithDateOfBirth
{
    
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[self dateFromString]];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

- (NSDate *)dateFromString
{
    //字符串转nsdate
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    //dateFormat 根据数据修改格式
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [inputFormatter dateFromString:self];
    
    return date;
}

+(NSString*) removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}

//判断是否有空格
- (BOOL)isHaveblank{

    NSRange _range = [self rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        
        //有空格
        return YES;
        
    }else {
        //没有空格
        
        return NO;
    }

}


//判断是否有emj表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}


//ali：7位  wx：8位

+ (NSString *)DecodedStringWithPara:(NSString *)para WithAli:(BOOL)isAli{
    
    
    
    
    NSString *base64Encoded ;
    
    if (isAli) {
        
        base64Encoded =  [para substringFromIndex:7];
        
        
    }else{
        
        base64Encoded =  [para substringFromIndex:8];
        
    }
    
    
    NSString *  restoreString = [[NSString alloc]initWithData:[[NSData alloc] initWithBase64EncodedString:base64Encoded options:NSDataBase64DecodingIgnoreUnknownCharacters] encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"Decoded: %@", restoreString);
    
    return restoreString;
    
}

+(NSString *)countNumAndChangeformat:(NSString *)string{
    
    NSString *sign = nil;
    
    if ([string hasPrefix:@"-"]||[string hasPrefix:@"+"]) {
        
        sign = [string substringToIndex:1];
        
        string = [string substringFromIndex:1];
        
    }
    
    NSString *pointLast = [string substringFromIndex:[string length]-3];
    
    NSString *pointFront = [string substringToIndex:[string length]-3];
    
    
    
    int commaNum = ([pointFront length]-1)/3;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i < commaNum+1; i++) {
        
        int index = [pointFront length] - (i+1)*3;
        
        int leng = 3;
        
        if(index < 0)
            
        {
            
            leng = 3+index;
            
            index = 0;
            
            
            
        }
        
        NSRange range = {index,leng};
        
        NSString *stq = [pointFront substringWithRange:range];
        
        [arr addObject:stq];
        
    }
    
    NSMutableArray *arr2 = [NSMutableArray array];
    
    for (int i = [arr count]-1; i>=0; i--) {
        
        
        
        [arr2 addObject:arr[i]];
        
    }
    
    NSString *commaString = [[arr2 componentsJoinedByString:@","] stringByAppendingString:pointLast];
    
    if (sign) {
        
        commaString = [sign stringByAppendingString:commaString];
        
    }
    
    return commaString;
    
}

+ (int)countOfBlankStrWith:(NSString *)string{

    int num = 0;
    
    for (int i = 0; i < string.length; i ++ ) {
        
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if ([str isEqualToString:@" "]) {
            
            num += 1;
        }
    }
    
    return num;
}


+ (int)countOfArguementCharStrWith:(NSString *)string{
    
    int num = 0;
    
    for (int i = 0; i < string.length; i ++ ) {
        
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if ([str isEqualToString:@"#"]) {
            
            num += 1;
        }
    }
    
    return num;
}


+ (NSMutableAttributedString *)setupTopicWithString:(NSString *)str{
    
    if (str == nil) {
        
        str = @"";
    }

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    // 创建正则表达式对象
    NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:@"#.*?#" options:0 error:&error];
    
    NSArray *topicRanges = [NSString getRangesFromResult:regex WithStr:str];
    //    self.topicRangesArr = topicRanges;
    for (NSValue *value in topicRanges) {
        NSRange range;
        [value getValue:&range];
        [attStr addAttribute:NSForegroundColorAttributeName value:RedColor range:range];
    }
    
    return attStr;
    
}

+(NSArray *)getRangesFromResult:(NSRegularExpression *)regex WithStr:(NSString *)str{
    
    NSArray<NSTextCheckingResult *> *results = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    // 2.遍历结果
    NSMutableArray *ranges = [NSMutableArray array];
    for (NSTextCheckingResult *result in results) {
        
        // 将结构体保存到数组
        // 先用一个变量接受结构体
        NSRange range = result.range;
        NSValue *value = [NSValue valueWithBytes:&range objCType:@encode(NSRange)];
        [ranges addObject:value];
    }
    
    return ranges;
}

@end
