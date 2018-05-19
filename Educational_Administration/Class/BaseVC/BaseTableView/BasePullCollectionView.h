//
//  BasePullCollectionView.h
//  YunDi_Student
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BasePullCollectionView;

@protocol PullCollectionViewDelegate <NSObject>

@optional
- (void)pullCollectionViewDidTriggerRefresh:(BasePullCollectionView *)pullTableView;
- (void)pullCollectionViewDidTriggerLoadMore:(BasePullCollectionView *)pullTableView;

@end

@interface BasePullCollectionView : UICollectionView

@property (nonatomic,assign) BOOL haveLoadAll;

@property (nonatomic, assign) IBOutlet id<PullCollectionViewDelegate> pullDelegate;


@end
