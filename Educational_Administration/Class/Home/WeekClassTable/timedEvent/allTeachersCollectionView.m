//
//  allTeachersCollectionView.m
//  Educational_Administration
//
//  Created by Apple on 2018/5/17.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "allTeachersCollectionView.h"
#import "MGCTimedEventsViewLayout.h"
#import "MGCEventCell.h"
#import "WeekClasstable.h"

#import "MGCStandardEventView.h"
#import "MGCDateRange.h"

static NSString* const EventCellReuseIdentifier = @"EventCellReuseIdentifier";



@interface allTeachersCollectionView ()<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,MGCTimedEventsViewLayoutDelegate>

@property (nonatomic, readonly) UICollectionView *timedEventsView;
@property (nonatomic, readonly) MGCTimedEventsViewLayout *timedEventsViewLayout;

@property (nonatomic) MGCReusableObjectQueue *reuseQueue;        // reuse queue for event views (MGCEventView)

@property (nonatomic) NSRange hourRange;


@end

@implementation allTeachersCollectionView

@synthesize timedEventsView = _timedEventsView;
@synthesize timedEventsViewLayout = _timedEventsViewLayout;


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        
        CGFloat timedEventsViewWidth = self.bounds.size.width;
        CGFloat timedEventsViewHeight = self.bounds.size.height ;
        
        
        self.timedEventsView.frame = CGRectMake(0, 0, timedEventsViewWidth, timedEventsViewHeight);
        if (!self.timedEventsView.superview) {
            [self addSubview:self.timedEventsView];
        }
        
        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    

    
    self.timedEventsViewLayout.dayColumnSize = self.dayColumnSize;

    
}


#pragma mark - Subviews

- (UICollectionView*)timedEventsView
{
    if (!_timedEventsView) {
        _timedEventsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.timedEventsViewLayout];
        _timedEventsView.backgroundColor = [UIColor clearColor];
        _timedEventsView.dataSource = self;
        _timedEventsView.delegate = self;
        _timedEventsView.showsVerticalScrollIndicator = NO;
        _timedEventsView.showsHorizontalScrollIndicator = NO;
        _timedEventsView.scrollsToTop = NO;
        _timedEventsView.decelerationRate = UIScrollViewDecelerationRateFast;
        _timedEventsView.allowsSelection = NO;
        _timedEventsView.directionalLockEnabled = YES;
        
        //        _timedEventsView.backgroundColor = [UIColor blueColor];
        
        [_timedEventsView registerClass:MGCEventCell.class forCellWithReuseIdentifier:EventCellReuseIdentifier];
//        [_timedEventsView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:DimmingViewKind withReuseIdentifier:DimmingViewReuseIdentifier];
        UILongPressGestureRecognizer *longPress = [UILongPressGestureRecognizer new];
        //        [longPress addTarget:self action:@selector(handleLongPress:)];
        //        [_timedEventsView addGestureRecognizer:longPress];
        
//        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
//        [tap addTarget:self action:@selector(handleTap:)];
//        [_timedEventsView addGestureRecognizer:tap];
//
//        UIPinchGestureRecognizer *pinch = [UIPinchGestureRecognizer new];
//        [pinch addTarget:self action:@selector(handlePinch:)];
//        [_timedEventsView addGestureRecognizer:pinch];
    }
    return _timedEventsView;
}

#pragma mark - Layouts

- (MGCTimedEventsViewLayout*)timedEventsViewLayout
{
    if (!_timedEventsViewLayout) {
        _timedEventsViewLayout = [MGCTimedEventsViewLayout new];
        _timedEventsViewLayout.delegate = self;
        _timedEventsViewLayout.dayColumnSize = self.dayColumnSize;
        _timedEventsViewLayout.coveringType =/* self.eventCoveringType == TimedEventCoveringTypeComplex ? TimedEventCoveringTypeComplex :*/ TimedEventCoveringTypeClassic;
    }
    return _timedEventsViewLayout;
}

//- (MGCEventCell*)collectionViewCellForEventOfType:(MGCEventType)type atIndexPath:(NSIndexPath*)indexPath
//{
//    MGCEventCell *cell = nil;
//    cell = (MGCEventCell*)[self.timedEventsView cellForItemAtIndexPath:indexPath];
//
//    return cell;
//}


- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    
#pragma mark - 事件个数
    if (collectionView == self.timedEventsView) {
        return 3; //[self.dataSource dayPlannerView:self numberOfEventsOfType:MGCTimedEventType atDate:date];
    }
    return 1; // for dayColumnView
}
#pragma mark - 动态数据  老师个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 7;//self.numberOfLoadedDays;
}

- (UICollectionViewCell*)dequeueCellForEventOfType:(MGCEventType)type atIndexPath:(NSIndexPath*)indexPath
{
    NSDate *date = nil; //[self dateFromDayOffset:indexPath.section];
    NSUInteger index = indexPath.item;
    MGCEventView *cell = [self dayPlannerView:self viewForEventOfType:type atIndex:index date:date];
    
    MGCEventCell *cvCell = nil;
    if (type == MGCTimedEventType) {
        cvCell = (MGCEventCell*)[self.timedEventsView dequeueReusableCellWithReuseIdentifier:EventCellReuseIdentifier forIndexPath:indexPath];
    }
    cvCell.backgroundColor = [UIColor redColor];
    cvCell.eventView = cell;
    //    if ([self.selectedCellIndexPath isEqual:indexPath] && self.selectedCellType == type) {
    //        cvCell.selected = YES;
    //    }
    
    return cvCell;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (collectionView == self.timedEventsView) {
        return [self dequeueCellForEventOfType:MGCTimedEventType atIndexPath:indexPath];
    }
    //    else if (collectionView == self.allDayEventsView) {
    //        return [self dequeueCellForEventOfType:MGCAllDayEventType atIndexPath:indexPath];
    //    }
//    else if (collectionView == self.dayColumnsView) {
//        return [self dayColumnCellAtIndexPath:indexPath];
//    }
    return nil;
}


- (MGCEventView*)dayPlannerView:(allTeachersCollectionView *)view viewForEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
    //    EKEvent *ev = [self eventOfType:type atIndex:index date:date];
    
    MGCStandardEventView *evCell = (MGCStandardEventView*)[view dequeueReusableViewWithIdentifier:EventCellReuseIdentifier forEventOfType:type atIndex:index date:date];
    evCell.font = [UIFont systemFontOfSize:11];
    evCell.title = @"课程"; //ev.title;
    evCell.subtitle = @"详情"; //ev.location;
    evCell.color = [UIColor colorWithCGColor:[UIColor orangeColor].CGColor];
    evCell.style = MGCStandardEventViewStylePlain|MGCStandardEventViewStyleSubtitle;
    evCell.style |= (type == MGCAllDayEventType) ?: MGCStandardEventViewStyleBorder;
    return evCell;
}

- (MGCEventView*)dequeueReusableViewWithIdentifier:(NSString*)identifier forEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
    return (MGCEventView*)[self.reuseQueue dequeueReusableObjectWithReuseIdentifier:identifier];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(eachTeacherEventCellWidth, self.bounds.size.height);
}



#pragma mark - MGCTimedEventsViewLayoutDelegate

- (CGRect)collectionView:(UICollectionView *)collectionView layout:(MGCTimedEventsViewLayout *)layout rectForEventAtIndexPath:(NSIndexPath *)indexPath
{
    
    //日期
    NSDate *date = [NSDate date]; // [self dateFromDayOffset:indexPath.section];
    
    MGCDateRange *dayRange = [self scrollableTimeRangeForDate:date];
    MGCDateRange* eventRange = [self dayPlannerView:self dateRangeForEventOfType:MGCTimedEventType atIndex:indexPath.item date:date];
    NSAssert(eventRange, @"[AllDayEventsViewLayoutDelegate dayPlannerView:dateRangeForEventOfType:atIndex:date:] cannot return nil!");
    
    [eventRange intersectDateRange:dayRange];
    
    if (!eventRange.isEmpty) {
        CGFloat y1 = [self offsetFromDate:eventRange.start];
        CGFloat y2 = [self offsetFromDate:eventRange.end];
        
        return CGRectMake(0, y1, 0, y2 - y1);
    }
    return CGRectNull;
}

- (NSArray*)dimmedTimeRangesAtDate:(NSDate*)date
{
    NSMutableArray *ranges = [NSMutableArray array];
    
    //    if ([self.delegate respondsToSelector:@selector(dayPlannerView:numberOfDimmedTimeRangesAtDate:)]) {
    //        NSInteger count = [self.delegate dayPlannerView:self numberOfDimmedTimeRangesAtDate:date];
    //
    //        if (count > 0 && [self.delegate respondsToSelector:@selector(dayPlannerView:dimmedTimeRangeAtIndex:date:)]) {
    //            MGCDateRange *dayRange = [self scrollableTimeRangeForDate:date];
    //
    //            for (NSUInteger i = 0; i < count; i++) {
    //                MGCDateRange *range = [self.delegate dayPlannerView:self dimmedTimeRangeAtIndex:i date:date];
    //
    //                [range intersectDateRange:dayRange];
    //
    //                if (!range.isEmpty) {
    //                    [ranges addObject:range];
    //                }
    //            }
    //        }
    //    }
    return ranges;
}

- (NSArray*)collectionView:(UICollectionView *)collectionView layout:(MGCTimedEventsViewLayout *)layout dimmingRectsForSection:(NSUInteger)section
{
    //    NSDate *date = [self dateFromDayOffset:section];
    //
    //    NSArray *ranges = [self.dimmedTimeRangesCache objectForKey:date];
    //    if (!ranges) {
    //        ranges = [self dimmedTimeRangesAtDate:date];
    //        [self.dimmedTimeRangesCache setObject:ranges forKey:date];
    //    }
    
    NSMutableArray *rects = [NSMutableArray arrayWithCapacity: 0];//ranges.count];
    
    //    for (MGCDateRange *range in ranges) {
    //        if (!range.isEmpty) {
    //            CGFloat y1 = [self offsetFromDate:range.start];
    //            CGFloat y2 = [self offsetFromDate:range.end];
    //
    //            [rects addObject:[NSValue valueWithCGRect:CGRectMake(0, y1, 0, y2 - y1)]];
    //        }
    //    }
    return rects;
}

// returns the scrollable time range for the day at date, depending on hourRange
- (MGCDateRange*)scrollableTimeRangeForDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *dayRangeStart = [calendar dateBySettingHour:self.hourRange.location minute:0 second:0 ofDate:date options:0];
    NSDate *dayRangeEnd = [calendar dateBySettingHour:NSMaxRange(self.hourRange) - 1 minute:59 second:0 ofDate:date options:0];
    return [MGCDateRange dateRangeWithStart:dayRangeStart end:dayRangeEnd];
}


- (MGCDateRange*)dayPlannerView:(WeekClasstable*)view dateRangeForEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
#pragma mark - 获取课程 并返回开始结束时间
    
    //    EKEvent *ev = [self eventOfType:type atIndex:index date:date];
    
    
    
    return [MGCDateRange dateRangeWithStart: [NSDate date] end:[NSDate dateWithTimeIntervalSinceNow:40 * 60] ];//ev.startDate end:ev.endDate];
}


- (CGFloat)offsetFromDate:(NSDate*)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:date];
    CGFloat y = roundf((comp.hour + comp.minute / 60. - self.hourRange.location) * self.hourSlotHeight + self.eventsViewInnerMargin);
    // when the following line is commented, event cells and dimming views are not constrained to the visible hour range
    // (ie cells can show past the edge of content)
    //y = fmax(self.eventsViewInnerMargin, fmin(self.dayColumnSize.height - self.eventsViewInnerMargin, y));
    return MGCAlignedFloat(y);
}

@end
