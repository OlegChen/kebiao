//
//  TeacherVC.m
//  Educational_Administration
//
//  Created by Apple on 2018/5/18.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "TeacherVC.h"
#import "BasePullTableView.h"
#import "TeacherVCCell.h"

@interface TeacherVC ()<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>

@property (nonatomic,strong) BasePullTableView *tableView;

@end

@implementation TeacherVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[BasePullTableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    _tableView.pullDelegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_tableView registerNib:[UINib nibWithNibName:@"TeacherVCCell" bundle:nil] forCellReuseIdentifier:TeacherVCCell_id];
    
    _tableView.tableHeaderView = ({
        
       UIView *view = [[UIView alloc]init];
        view.height = 10;
        view;
    });
    
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeacherVCCell *cell = [tableView dequeueReusableCellWithIdentifier:TeacherVCCell_id forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)pullTableViewDidTriggerRefresh:(BasePullTableView *)pullTableView{
    
    [_tableView.mj_header endRefreshing];
    
}

- (void)pullTableViewDidTriggerLoadMore:(BasePullTableView *)pullTableView{
    
    
    [_tableView.mj_footer endRefreshing];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
//    HomeVC *vc = [[HomeVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];

    
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
