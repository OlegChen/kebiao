////
////  SqliteManager.m
////  YunDi_Student
////
////  Created by apple on 2017/6/7.
////  Copyright © 2017年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
////
//
//#import "SqliteManager.h"
//
//#import "FMDatabase.h"
//
//#import "newHomeVideoResultModel.h"
//#import "NewHomeBannerBannerModel.h"
//
//
//@interface SqliteManager ()
//
//@property (nonatomic ,strong) FMDatabase *db;
//
//@end
//
//@implementation SqliteManager
//
//
//
//+ (instancetype)shareManager{
//    static SqliteManager *manager = nil;
//    static dispatch_once_t pred;
//    dispatch_once(&pred, ^{
//        manager = [[self alloc] init];
//        manager.db = [FMDatabase databaseWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"db.sqlite" ]];
//
//
//    });
//    return manager;
//}
//
////新首页视频
//- (void)setupAddressSqlite{
//
//
//    // 打开数据库
//    if ([_db open]) {
//
//        // 创建表
//        BOOL success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS newHomeVideo_T(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, vedioUrl TEXT , title TEXT, img TEXT, breif TEXT, headerImg TEXT ,createDateStr TEXT , vedioId TEXT , custId TEXT);"];
//
//        if (success) {
//            NSLog(@"创建表成功");
//
//            BOOL success = [_db executeUpdate:@"delete from newHomeVideo_T"];
//            [_db executeUpdate:@"UPDATE sqlite_sequence set seq=0 where name='newHomeVideo_T'"];
//
//                if (success) {
//                    NSLog(@"清空数据数据成功");
//                }else
//                {
//                    NSLog(@"清空数据失败");
//                }
//
//
//        }else
//        {
//            NSLog(@"创建表失败");
//        }
//    }else
//    {
//        NSLog(@"打开失败");
//    }
//
//}
//
////插入
//-(void)insertNewHomeVideoListWithArray:(NSArray *)arr
//{
//    // 增加一条数据，在表中插入一条记录user值，由于id是自增，可以不传
//
//    for ( newHomeVideoResultModel *model in  arr) {
//
//        // 1.拿到数据库对象插入数据
//        //
//        BOOL success = [self.db executeUpdate:@"INSERT INTO newHomeVideo_T(name , vedioUrl  , title , img , breif , headerImg  ,createDateStr  , vedioId , custId) VALUES(? , ? , ?, ?, ?, ?, ?, ? ,?);",model.name , model.vedioUrl  , model.title , model.img , model.breif , model.headerImg  ,model.createDateStr  , model.vedioId ,model.custId];
//        if (success) {
//            NSLog(@"保存数据成功");
//        }else
//        {
//            NSLog(@"保存数据失败");
//        }
//    }
//
//}
//
//
////读取到的数据
//- (NSArray *)cacheNewHomeVideoList{
//
////    FMDatabase* db = [FMDatabase databaseWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"db.sqlite" ]];
//    BOOL res = [self.db open];
//    if (res == NO) {
//        NSLog(@"打开失败");
//        return nil;
//    }
//
//    FMResultSet* set = [self.db executeQuery:@"select * from newHomeVideo_T"];
////    _db = [FMDatabase databaseWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"db.sqlite" ]];
//
//    NSLog(@"%@",[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"db.sqlite"]);
//
////    set = [_db executeQuery:@"SELECT * FROM newHomeVideo_T"];
//
//    NSMutableArray *models = [NSMutableArray array];
//    while ([set next]) {
//
//        newHomeVideoResultModel *model = [[newHomeVideoResultModel alloc]init];
//
//        //int Id = [set intForColumn:Id];
//        model.name = [set stringForColumn:@"name"];
//        model.vedioUrl = [set stringForColumn:@"vedioUrl"];
//        model.title = [set stringForColumn:@"title"];
//        model.img = [set stringForColumn:@"img"];
//        model.breif = [set stringForColumn:@"breif"];
//        model.headerImg = [set stringForColumn:@"headerImg"];
//        model.createDateStr = [set stringForColumn:@"createDateStr"];
//        model.vedioId = [set stringForColumn:@"vedioId"];
//        model.custId = [set stringForColumn:@"custId"];
//
//
//
//        // 将模型添加到数组中
//        [models addObject:model];
//    }
//
//    [self.db close];
//
//
//    // 3.返回数组
//    return models;
//}
//
//
//
//
//
////新首页 banner
//- (void)setupBannerSqlite{
//
//
//    // 打开数据库
//    if ([_db open]) {
//
//        // 创建表
//        BOOL success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS newHomeBanner_T(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, vedioId TEXT, type TEXT , title TEXT, h5Url TEXT, img TEXT);"];
//
//        if (success) {
//            NSLog(@"创建表成功");
//
//            BOOL success = [_db executeUpdate:@"delete from newHomeBanner_T"];
//            [_db executeUpdate:@"UPDATE sqlite_sequence set seq=0 where name='newHomeBanner_T'"];
//
//            if (success) {
//                NSLog(@"清空数据数据成功");
//            }else
//            {
//                NSLog(@"清空数据失败");
//            }
//
//
//        }else
//        {
//            NSLog(@"创建表失败");
//        }
//    }else
//    {
//        NSLog(@"打开失败");
//    }
//
//}
//
////插入
//-(void)insertNewHomeBannerListWithArray:(NSArray *)arr
//{
//    // 增加一条数据，在表中插入一条记录user值，由于id是自增，可以不传
//
//    for ( NewHomeBannerBannerModel *model in  arr) {
//
//        // 1.拿到数据库对象插入数据
//        //
//        BOOL success = [self.db executeUpdate:@"INSERT INTO newHomeBanner_T(vedioId , type  , title , h5Url , img  ) VALUES(? , ? , ?, ?, ?);",model.vedioId , model.type  , model.title , model.h5Url , model.img ];
//        if (success) {
//            NSLog(@"保存数据成功");
//        }else
//        {
//            NSLog(@"保存数据失败");
//        }
//    }
//
//}
//
//
////读取到的数据
//- (NSArray *)cacheNewHomeBannerList{
//
//    //    FMDatabase* db = [FMDatabase databaseWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"db.sqlite" ]];
//    BOOL res = [self.db open];
//    if (res == NO) {
//        NSLog(@"打开失败");
//        return nil;
//    }
//
//    FMResultSet* set = [self.db executeQuery:@"select * from newHomeBanner_T"];
//
//    NSLog(@"%@",[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"db.sqlite"]);
//
//    NSMutableArray *models = [NSMutableArray array];
//    while ([set next]) {
//
//        NewHomeBannerBannerModel *model = [[NewHomeBannerBannerModel alloc]init];
//
//        //int Id = [set intForColumn:Id];
//        model.h5Url = [set stringForColumn:@"h5Url"];
//        model.title = [set stringForColumn:@"title"];
//        model.img = [set stringForColumn:@"img"];
//        model.type = [set stringForColumn:@"type"];
//        model.vedioId = [set stringForColumn:@"vedioId"];
//
//
//        // 将模型添加到数组中
//        [models addObject:model];
//    }
//    
//    [self.db close];
//
//
//    // 3.返回数组
//    return models;
//}
//
//
//
//
//
//
//@end

