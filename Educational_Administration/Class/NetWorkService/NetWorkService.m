//
//  NetWorkService.m
//  Educational_Administration
//
//  Created by Apple on 2018/5/9.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "NetWorkService.h"
#import "NetWork.h"

@implementation NetWorkService


//post
+ (void)networkPostrequestParameters:(NSDictionary *)dic requestApi:(NSString *)url modelClass:(NSString*) modelClass  CompletionHandler:(RequestSuccessBlock)succession
                        errorHandler:(RequestfaildBlock)failed{

    NSLog(@"%@",dic);
    
    
    [[NetWork shareNetwork] requestWithDic:dic url:url success:^(AFHTTPSessionManager *operation,id Object) {
            
//            //等待控件是否消失处理
//            if (stop) {
//                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
//            }
        
            if (modelClass == nil || [modelClass isEqualToString:@""]) {
                
                //无模型转 传回字典
                succession(Object);
                
            }else{
                
                
                NSString *className = modelClass;
                if (!className) {
                    className = NSStringFromClass([className class]);
                }
                
                id  model = [NSClassFromString(className)  mj_objectWithKeyValues:Object];
                
                if (succession) {
                    succession(model);
                }
                
                //            }
                
                
                
            }
        } failure:^(AFHTTPSessionManager *operation, NSError *error) {
            
            
                //提示
                [MBProgressHUD showHudTipStr:@"网络错误"];
                //隐藏菊花
            
            
            if (failed) {
                failed(error);
            }
            //        }
        }];
    }


@end
