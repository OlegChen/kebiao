//
//  BasePullCollectionView.m
//  YunDi_Student
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import "BasePullCollectionView.h"

#import "MJRefresh.h"

@implementation BasePullCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self config];
    }
    
    return self;
}


- (void)config
{
    //    delegateInterceptor = [[MessageInterceptor alloc] init];
    //    delegateInterceptor.middleMan = self;
    //    delegateInterceptor.receiver = self.delegate;
    //    super.delegate = (id)delegateInterceptor;
    
    // 防止block循环retain，所以用__unsafe_unretained
    
    
    //下拉刷新
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    
    //    [self.mj_header beginRefreshing];
    
    
#pragma mark - 自定义动画 刷新
    //    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    //    CustomerRefreshHeader *header = [CustomerRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewRefresh)];
    //    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    //    // 隐藏状态
    //    header.stateLabel.hidden = YES;
    //    // 设置header
    //    self.mj_header = header;
    
    // 立即刷新
    //    [self.mj_header beginRefreshing];
    
    //    self.pagingEnabled = false;
    // 上拉加载更多控
    //    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewLoadMore)];
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
    // 无数据隐藏
    self.mj_footer.automaticallyHidden = YES;
    
    
    
}

#pragma mark - 上拉下拉刷新


- (void)Refresh{
    
    if ([_pullDelegate respondsToSelector:@selector(pullCollectionViewDidTriggerRefresh:)])
        [_pullDelegate pullCollectionViewDidTriggerRefresh:self];
    
    
    [self.mj_footer resetNoMoreData];
    
}

- (void)LoadMore{
    
    if ([_pullDelegate respondsToSelector:@selector(pullCollectionViewDidTriggerLoadMore:)])
        [_pullDelegate pullCollectionViewDidTriggerLoadMore:self];
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setHaveLoadAll:(BOOL)haveLoadAll
{
    //    self.haveLoadAll = haveLoadAll;
    
    if (haveLoadAll) {
        
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        
        [self.mj_footer endRefreshing];
    }
    
    
}

@end
