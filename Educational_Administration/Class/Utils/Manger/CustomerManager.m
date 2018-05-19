//
//  CustomerManager.m
//  YunDi_Student
//
//  Created by Chen on 16/9/21.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#define isFirstEnter  @"isFirstEnter"

#define cityName_id @"cityName"
#define cityCode_id @"cityCode"


#import "CustomerManager.h"
//#import "SAMKeychain.h"
#import <CommonCrypto/CommonDigest.h>

//#import "LoginModel.h"

//#import "MyChildren.h"
//
//#import "MyMessageBaseTypeModel.h"


@implementation CustomerManager

+ (BOOL) isFirstEnterApp{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults objectForKey:isFirstEnter]) {
        
        [userDefaults setBool:YES forKey:isFirstEnter];
        return YES;
        
    }else{
    
        return NO;
    }
}

//+ (NSString *)getUUID{
//
//    NSString *uuid;
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if (![userDefaults objectForKey:isFirstEnter]) {
//
//        CFUUIDRef puuid = CFUUIDCreate(nil);
//        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
//        NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
//        NSMutableString *tmpResult = result.mutableCopy;
//        // 去除“-”
//        NSRange range = [tmpResult rangeOfString:@"-"];
//        while (range.location != NSNotFound) {
//            [tmpResult deleteCharactersInRange:range];
//            range = [tmpResult rangeOfString:@"-"];
//        }
//        NSLog(@"UUID:%@",tmpResult);
//        uuid = tmpResult;
//
//        //保存到keychain
//
//        [SAMKeychain setPassword:tmpResult forService:@"com.FengyunDiyin.Student" account:@"UUID"];
//
//        return tmpResult;
//
//    }else{
//
//        //从keychain读取
//
//        NSLog(@"%@",[SAMKeychain passwordForService:@"com.FengyunDiyin.Student" account:@"UUID"]);
//
//        return [SAMKeychain passwordForService:@"com.FengyunDiyin.Student" account:@"UUID"];
//
//    }
//}

+ (NSString *)MD5WithStr:(NSString *)str{

    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, strlen(cStr), result );
    
    NSString *md5_32Bit_String = [NSString stringWithFormat:
                                  
                                  @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                  
                                  result[0], result[1], result[2], result[3],
                                  
                                  result[4], result[5], result[6], result[7],
                                  
                                  result[8], result[9], result[10], result[11],
                                  
                                  result[12], result[13], result[14], result[15]
                                  
                                  ];  // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
    
    //    NSString *resultStr = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return md5_32Bit_String;

}

#pragma mark - 字数限制

+ (void)limtitLength:(UITextField *)textfield WithLenght:(int )length{
    
    NSString *toBeString = textfield.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textfield markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textfield positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > length) {
                textfield.text = [toBeString substringToIndex:length];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }

    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > length) {
            textfield.text = [toBeString substringToIndex:length];
        }
    }

    
    //空格
    if ( toBeString.length > 0 && [[toBeString substringFromIndex:toBeString.length - 1] isEqualToString:@" "]) {
        
        textfield.text = [toBeString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    
}

#pragma mark - 字数限制  --- 可以输入空字符串

+ (void)limtitLengthCanEnterBlankStrWithTextField:(UITextField *)textfield WithLenght:(int )length{
    
    NSString *toBeString = textfield.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textfield markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textfield positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > length) {
                textfield.text = [toBeString substringToIndex:length];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > length) {
            textfield.text = [toBeString substringToIndex:length];
        }
    }
    
}

//endtime 当前时间
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    
    NSDate *startD =[date dateFromString:startTime];
    
//    NSDate *endD = [date dateFromString:endTime];

    
    NSTimeInterval interval = 24*60*60*1;
   NSDate *endD  = [startD dateByAddingTimeInterval:interval];
    
//    NSDate *endD = [startD dateByAddingTimeInterval:24*60*60];
    NSDate *nowDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval11 = [zone secondsFromGMTForDate: nowDate];
    NSDate *localeDate = [nowDate  dateByAddingTimeInterval: interval11];
    
    NSTimeInterval now = [localeDate timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = (end - now);
    
//    int second = (int)value %60;//秒
    
    int house = (int)(value / 3600);
    
    int minute = (int)(value - house * 3600) /60;
    
    
//    int day = (int)value / (24 * 3600);
    
    NSString *str;
    
//    if (day != 0) {
//        
//        str = [NSString stringWithFormat:@"%d天%d小时%d分%d秒",day,house,minute,second];
//        
//    }else if (day==0 && house != 0) {
//        
        str = [NSString stringWithFormat:@"%d小时%d分",house,minute];
        
//    }else if (day== 0 && house== 0 && minute!=0) {
//        
//        str = [NSString stringWithFormat:@"%d分%d秒",minute,second];
//        
//    }else{
//        
//        str = [NSString stringWithFormat:@"%d秒",second];
//        
//    }
    
    //如果到时间返回空
    if (value <= 0) {
        
        return @"";
    }
    
    return str;
    
}


//+ (void)updateUserDataWithLoginModel:(UpdateUserInfo)userInfo{
//
//    UserModel *userModel = [UserCenter curLoginUser];
//
//    [NetWork queryCustomerWithCustId:userModel.custId WaitAnimation:YES CompletionHandler:^(id object) {
//
//        LoginModel *model = object;
//
//        if (model.statusCode == 800) {
//
//            NSLog(@"%@",model.returnObj);
//            [UserCenter doLogin:model.returnObj];
//
//            if (userInfo) {
//                userInfo(model.returnObj);
//            }
//
//        }else{
//
//            [MBProgressHUD showHudTipStr:model.returnObj.msg];
//        }
//
//
//    } errorHandler:^(id object) {
//
//
//    }];
//
//}

//+ (BOOL)CanEnterClassDetailWithVC:(BaseViewController *)vc WithClassCategoryId:(NSString *)categoryId WithClassLevel:(int)ClassLevel{
//
//    if ([categoryId isEqualToString:@"C01"]) {
//        //一对一
//
//        //登录判断
//        if (![vc islogined]) {
//
//            return NO;
//        }
//
//        //等级判断
//        UserModel *userModel = [UserCenter curLoginUser];
//
//        if (userModel.CePingLevel == 0) {
//
//            //未测评 -- 跳转测评
//            [[UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"一对一课程需先进行测评，以便为您更准确的匹配课程" cancelButtonTitle:@"知道了" otherButtonTitles:@[@"立即测评"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//
//                if (buttonIndex == 0) {
//
//
//                }else{
//
//                    //去测评
//                    MyChildren *children = [[MyChildren alloc]init];
//                    children.userModel = userModel;
//                    [vc.navigationController pushViewController:children animated:YES];
//
//                }
//
//            }] show];
//
//            return NO;
//
//
//        }else{
//
////            if (userModel.CePingLevel < ClassLevel) {
////
////                //用户测评等级未达到课程等级  无法查看
////                [[UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"您的测评等级无法查看该课程" cancelButtonTitle:@"确定" otherButtonTitles:@[] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
////
////                }] show];
////
////                return NO;
////
////            }else{
////
////
////                return YES;
////
////            }
//
//            return YES;
//        }
//
//    }else{
//
//        //非一对一
//
//        return YES;
//    }
//
//    return NO;
//
//}

+ (void)saveSelectedCityWithName:(NSString *)cityName WithCityCode:(NSString *)CityCode{

    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:cityName_id];
    
     [[NSUserDefaults standardUserDefaults] setObject:CityCode forKey:cityCode_id];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (void)getSelectedCityWithCityContent:(cityContent)cityContent{

    if (cityContent) {
        
        cityContent([[NSUserDefaults standardUserDefaults] objectForKey:cityName_id], [[NSUserDefaults standardUserDefaults] objectForKey:cityCode_id]);
    }
}


+ (void)setUnLocationMark{

    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"UnLocationMark"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getUnlocationMark{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UnLocationMark"];
    
}

////客服电话
//+ (void)CustomerServiceTel{
//
//    NSString *tel = [UserCenter getSeverTel];
//
//    if (tel) {
//        NSLog(@"客服电话  - - -- - - -  %@",tel);
//
//        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
//        //            NSLog(@"str======%@",str);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//
//        });
//
//
//    }else{
//
//        //7 国行 首次安装app 在appdelegate 里面获取不到tel  --- 处理
//
//        [NetWork queryBasParaConfigByConfigCodeWithconfigCode:@"003001" WaitAnimation:NO CompletionHandler:^(id object) {
//
//
//            NSDictionary *dic = object;
//
//            if ([[dic objectForKey:@"statusCode"] intValue] == 800) {
//
//                NSString *tel = [[dic objectForKey:@"returnObj"] objectForKey:@"configValue"];
//
//                //保存
//                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                [user setObject:tel forKey:TelPhoneNumberKey];
//                [user synchronize];
//
//                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
//                //            NSLog(@"str======%@",str);
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//
//                });
//
//            }else{
//
//                [MBProgressHUD showHudTipStr:@"获取客服电话失败，请稍后再试"];
//
//            }
//
//        } errorHandler:^(id object) {
//
//
//        }];
//
//    }
//}



@end
