//
//  HomeVC.m
//  Educational_Administration
//
//  Created by Apple on 2018/5/10.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "HomeVC.h"
#import "WeekClasstable.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WeekClasstable *classTable = [[WeekClasstable alloc]init];
    [self.view addSubview:classTable];
    [classTable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
