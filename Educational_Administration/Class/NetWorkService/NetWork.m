//
//  NetWork.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NetWork.h"

@interface NetWork ()

//@property (strong, nonatomic) NSMutableDictionary * muDicRequest;

@end

@implementation NetWork

static NetWork *sharedObj = nil;//第一步：静态实例，并初始化。

+ (NetWork *)shareNetwork
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

- (id)init
{
    if (self = [super init]) {

    }
    return self;
}



//网络请求
- (AFHTTPSessionManager *)requestWithDic:(NSDictionary *)dic
                                  url:(NSString *)url
                                 success:(void (^)(AFHTTPSessionManager *operation,id Object))success
                                 failure:(void (^)(AFHTTPSessionManager *operation, NSError *error))failure
{
    
//    NSString *baseURL = newAPI ? DefaultServerAddress2 : DefaultServerAddress;
    NSString *requestUrl = url;//[NSString stringWithFormat:@"%@/%@",baseURL,DefaultServerCommonASPX];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [dict setObject:tag forKey:@"requestCommand"];

    NSLog(@"\n🔷requestUrl = %@",requestUrl);
//    NSLog(@"\n🔷params = %@",dic);
    
    
    AFHTTPSessionManager *operationManager = [AFHTTPSessionManager manager];
    
    //根据传入参数生成请求
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];


    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    //------ 接收非json格式
//    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
//#pragma mark - 参数拼到url后面   方法
//    NSString *urlParametersStr = [self GetparametersStrWithDic:dic];
//    requestUrl = [requestUrl stringByAppendingString:urlParametersStr];
    
    [operationManager POST:requestUrl parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id object = responseObject;
        
        NSLog(@"返回--- %@",responseObject);

      
        if(success)
            success(operationManager,object);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure)
            failure(operationManager, error);
        
        NSLog(@"error -------   %@",error);
        
        }];
    

    return operationManager;
}




/*-----------分类-------------*/

- (NSString *)GetparametersStrWithDic:(NSDictionary *)dic{
    
    NSString *str = @"?";
    for (NSString *key in dic) {
        NSLog(@"key: %@ value: %@", key, dic[key]);
        
        NSString *keyValue = [NSString stringWithFormat:@"%@=%@&",key,dic[key]];
        str = [str stringByAppendingString:keyValue];
    }
    NSString * newString = [str substringWithRange:NSMakeRange(0, [str length] - 1)];
    
    return newString;
}


//json格式字符串转字典：

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


@end
