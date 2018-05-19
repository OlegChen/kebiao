//
//  CheckMemoryManger.m
//  YunDi_Student
//
//  Created by Chen on 16/8/24.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "CheckMemoryManger.h"
#include <sys/mount.h>

@implementation CheckMemoryManger


+ (NSString *) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return [NSString stringWithFormat:@"手机剩余存储空间为：%qi MB" ,freespace/1024/1024];
}


@end
