//
//  MeVC.m
//  Educational_Administration
//
//  Created by Apple on 2018/5/10.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "MeVC.h"

@interface MeVC ()

@end

@implementation MeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"ChangePwVCTableViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
#pragma mark - 退出
        
        
        
    }
    
    
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
