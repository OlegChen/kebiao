//
//  SqliteManager.h
//  YunDi_Student
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteManager : NSObject

+ (instancetype)shareManager;

- (void)setupAddressSqlite;
- (void)insertNewHomeVideoListWithArray:(NSArray *)arr;
- (NSArray *)cacheNewHomeVideoList;//:(IWRequestParameters *)parameters

- (void)setupBannerSqlite;
-(void)insertNewHomeBannerListWithArray:(NSArray *)arr;
- (NSArray *)cacheNewHomeBannerList;


@end
