//
//  NetWork.h
//  FengYunDi_Student
//
//  Created by Chen on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"


@interface NetWork : NSObject//,ApiUserRelatedProtocol,ApiHomeModuleProtocol,ApiChoiceAndDestinationProtocol>


typedef void (^RequestSuccessBlock) (id object);
typedef void (^RequestfaildBlock) (id object);


@property (nonatomic,strong)NSString* tag;//请求的标识
@property (nonatomic,strong)NSString* method;//请求的方法  支持POST GET
@property (nonatomic,strong)NSDictionary* dic;//请求的参数
@property (nonatomic,strong)NSString * strUrl;//请求的地址
//在appdelegate里面调用
+ (NetWork *)shareNetwork;

- (AFHTTPSessionManager *)requestWithDic:(NSDictionary *)dic
                                url:(NSString *)url
                                 success:(void (^)(AFHTTPSessionManager *operation,id Object))success
                                 failure:(void (^)(AFHTTPSessionManager *operation, NSError *error))failure;


@end
