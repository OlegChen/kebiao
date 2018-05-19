//
//  TeacherVC.h
//  Educational_Administration
//
//  Created by Apple on 2018/5/18.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    allTimeTeacher,
    partTimeTeacher,
} teacherType;

@interface TeacherVC : UIViewController

@property (nonatomic,assign) teacherType type;

@end
