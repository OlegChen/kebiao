//
//  allTeachersCollectiomCell.h
//  Educational_Administration
//
//  Created by Apple on 2018/5/18.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define eachTeacherEventCellWidth 80

@interface allTeachersCollectiomCell : UICollectionViewCell


@property (nonatomic,strong) NSArray *teahersData;

@property (nonatomic,assign) CGSize dayColumnSize;

@property (nonatomic,assign) CGFloat hourSlotHeight;
@property (nonatomic,assign) CGFloat eventsViewInnerMargin;


@end
