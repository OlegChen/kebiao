//
//  WeekClasstable.m
//  Educational_Administration
//
//  Created by Apple on 2018/5/10.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "WeekClasstable.h"
#import "MGCTimedEventsViewLayout.h"
#import "MGCDayColumnCell.h"
#import "MGCAlignedGeometry.h"
#import "MGCEventCell.h"
#import "MGCReusableObjectQueue.h"
#import "MGCStandardEventView.h"
#import "MGCDateRange.h"
#import "MGCTimeRowsView.h"
//#import "allTeachersCollectionView.h"
#import "allTeachersCollectiomCell.h"
//#import ""


// collection views cell identifiers
//static NSString* const EventCellReuseIdentifier = @"EventCellReuseIdentifier";
static NSString* const DimmingViewReuseIdentifier = @"DimmingViewReuseIdentifier";
static NSString* const DayColumnCellReuseIdentifier = @"DayColumnCellReuseIdentifier";
static NSString* const TimeRowCellReuseIdentifier = @"TimeRowCellReuseIdentifier";
static NSString* const MoreEventsViewReuseIdentifier = @"MoreEventsViewReuseIdentifier";   // test

static NSString* const allTeacherViewColumnIdentifier = @"allTeacherViewColumnIdentifier";


@interface allTeacherViewFlowLayout : UICollectionViewFlowLayout
@end

@implementation allTeacherViewFlowLayout

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    
    UICollectionViewFlowLayoutInvalidationContext *context = (UICollectionViewFlowLayoutInvalidationContext *)[super invalidationContextForBoundsChange:newBounds];
    CGRect oldBounds = self.collectionView.bounds;
    context.invalidateFlowLayoutDelegateMetrics = !CGSizeEqualToSize(newBounds.size, oldBounds.size);
    return context;
}

// we keep this for iOS 8 compatibility. As of iOS 9, this is replaced by collectionView:targetContentOffsetForProposedContentOffset:
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    id<UICollectionViewDelegate> delegate = (id<UICollectionViewDelegate>)self.collectionView.delegate;
    return [delegate collectionView:self.collectionView targetContentOffsetForProposedContentOffset:proposedContentOffset];
}


@end



@interface MGCDayColumnViewFlowLayout : UICollectionViewFlowLayout
@end

@implementation MGCDayColumnViewFlowLayout

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    
    UICollectionViewFlowLayoutInvalidationContext *context = (UICollectionViewFlowLayoutInvalidationContext *)[super invalidationContextForBoundsChange:newBounds];
    CGRect oldBounds = self.collectionView.bounds;
    context.invalidateFlowLayoutDelegateMetrics = !CGSizeEqualToSize(newBounds.size, oldBounds.size);
    return context;
}

// we keep this for iOS 8 compatibility. As of iOS 9, this is replaced by collectionView:targetContentOffsetForProposedContentOffset:
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    id<UICollectionViewDelegate> delegate = (id<UICollectionViewDelegate>)self.collectionView.delegate;
    return [delegate collectionView:self.collectionView targetContentOffsetForProposedContentOffset:proposedContentOffset];
}


@end



@interface WeekClasstable () <UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,MGCTimedEventsViewLayoutDelegate>

// subviews
@property (nonatomic, readonly) UICollectionView *allTeachersView;

//@property (nonatomic, readonly) UICollectionView *timedEventsView;
@property (nonatomic, readonly) UICollectionView *dayColumnsView;
@property (nonatomic, readonly) UIScrollView *timeScrollView;
@property (nonatomic, readonly) MGCTimedEventsViewLayout *timedEventsViewLayout;

@property (nonatomic) UIScrollView *controllingScrollView;        // the collection view which initiated scrolling - used for proper synchronization between the different collection views
@property (nonatomic) CGPoint scrollStartOffset;                // content offset in the controllingScrollView where scrolling started - used to lock scrolling in one direction
@property (nonatomic) ScrollDirection scrollDirection;            // direction or axis of the scroll movement

@property (nonatomic, readonly) MGCTimeRowsView *timeRowsView;

@property (nonatomic) CGFloat hourSlotHeightForGesture;


@property (nonatomic) CGFloat eventsViewInnerMargin;

@property (nonatomic) MGCReusableObjectQueue *reuseQueue;        // reuse queue for event views (MGCEventView)
@property (nonatomic) NSCalendar *calendar;
@property (nonatomic, copy) NSDate *startDate;                    // 今天所在的一周的周一的日期



@end

@implementation WeekClasstable

// readonly properties whose getter's defined are not auto-synthesized
//@synthesize timedEventsView = _timedEventsView;
@synthesize allTeachersView = _allTeachersView;
@synthesize dayColumnsView = _dayColumnsView;
@synthesize timeScrollView = _timeScrollView;

@synthesize timedEventsViewLayout = _timedEventsViewLayout;
//@synthesize allDayEventsViewLayout = _allDayEventsViewLayout;
//@synthesize startDate = _startDate;


#pragma mark - UIView

- (void)layoutSubviews
{
    //NSLog(@"layout subviews");
    
    [super layoutSubviews];
    
    CGSize dayColumnSize = self.dayColumnSize;
    
    self.timeRowsView.hourSlotHeight = self.hourSlotHeight;
    self.timeRowsView.timeColumnWidth = self.timeColumnWidth;
    self.timeRowsView.insetsHeight = self.eventsViewInnerMargin;
    
    self.timedEventsViewLayout.dayColumnSize = dayColumnSize;
    
    [self setupSubviews];
//    [self updateVisibleDaysRange];
}


- (void)setupSubviews
{
    
    CGFloat timedEventViewTop = self.dayHeaderHeight ;
    CGFloat timedEventsViewWidth = self.bounds.size.width - self.timeColumnWidth;
    CGFloat timedEventsViewHeight = self.bounds.size.height - (self.dayHeaderHeight );
    
    //self.backgroundView.frame = CGRectMake(0, self.dayHeaderHeight, self.bounds.size.width, self.bounds.size.height - self.dayHeaderHeight);
//    self.backgroundView.frame = CGRectMake(self.timeColumnWidth, self.dayHeaderHeight , timedEventsViewWidth, timedEventsViewHeight);
//    self.backgroundView.frame = CGRectMake(0, timedEventViewTop, self.bounds.size.width, timedEventsViewHeight);
//    if (!self.backgroundView.superview) {
//        [self addSubview:self.backgroundView];
//    }
    
    
//        self.dayColumnsView.frame = CGRectMake(self.timeColumnWidth, 0, timedEventsViewWidth, self.bounds.size.height);
//        if (!self.dayColumnsView.superview) {
//            [self addSubview:self.dayColumnsView];
//        }
    
    
    self.allTeachersView.frame = CGRectMake(self.timeColumnWidth, timedEventViewTop, timedEventsViewWidth, timedEventsViewHeight);
    if (!self.allTeachersView.superview) {
        [self addSubview:self.allTeachersView];
    }
    
    self.timeScrollView.contentSize = CGSizeMake(self.bounds.size.width, self.dayColumnSize.height);
    
    self.timeScrollView.frame = CGRectMake(0, timedEventViewTop, self.bounds.size.width, timedEventsViewHeight);
    if (!self.timeScrollView.superview) {
        [self addSubview:self.timeScrollView];
    }
    
    
    self.timeScrollView.contentSize = CGSizeMake(self.bounds.size.width, self.dayColumnSize.height);
    self.timeRowsView.frame = CGRectMake(0, 0, self.timeScrollView.contentSize.width, self.timeScrollView.contentSize.height);
    
    self.timeScrollView.frame = CGRectMake(0, timedEventViewTop, self.bounds.size.width, timedEventsViewHeight);
    if (!self.timeScrollView.superview) {
        [self addSubview:self.timeScrollView];
    }
    
    self.timeRowsView.showsCurrentTime = NO;
    
    self.timeScrollView.userInteractionEnabled = NO;
    
    
    self.dayColumnsView.frame = CGRectMake(self.timeColumnWidth, 0, timedEventsViewWidth, self.bounds.size.height);
    if (!self.dayColumnsView.superview) {
        [self addSubview:self.dayColumnsView];
    }
    
    self.dayColumnsView.userInteractionEnabled = NO;

    
    // make sure collection views are synchronized
    self.dayColumnsView.contentOffset = CGPointMake(self.allTeachersView.contentOffset.x, 0);
    self.timeScrollView.contentOffset = CGPointMake(0, self.allTeachersView.contentOffset.y);
    
//    if (self.dragTimer == nil && self.interactiveCell && self.interactiveCellDate) {
//        CGRect frame = self.interactiveCell.frame;
//        frame.origin = [self offsetFromDate:self.interactiveCellDate eventType:self.interactiveCellType];
//        frame.size.width = self.dayColumnSize.width;
//        self.interactiveCell.frame = frame;
//        self.interactiveCell.hidden = (self.interactiveCellType == MGCTimedEventType && !CGRectIntersectsRect(self.timedEventsView.frame, frame));
//    }
//
//    [self.allDayEventsView flashScrollIndicators];
}


- (void)setup
{
    
//    _eventCoveringType = TimedEventCoveringTypeClassic;

//    _numberOfVisibleDays = 7;
    _hourSlotHeight = 65.;
    _hourRange = NSMakeRange(8, 14);
    _timeColumnWidth = 60.;
    _dayHeaderHeight = 86.;
    _daySeparatorsColor = [UIColor lightGrayColor];
    _timeSeparatorsColor = [UIColor lightGrayColor];
//    _currentTimeColor = [UIColor redColor];
//    _eventIndicatorDotColor = [UIColor blueColor];
//    _showsAllDayEvents = YES;
//    _eventsViewInnerMargin = 15.;
//    _allDayEventCellHeight = 20;
//    _dimmingColor = [UIColor colorWithWhite:.9 alpha:.5];
//    _pagingEnabled = YES;
//    _zoomingEnabled = YES;
//    _canCreateEvents = YES;
//    _canMoveEvents = YES;
//    _allowsSelection = YES;
//    _eventCoveringType = TimedEventCoveringTypeClassic;
//
//    _reuseQueue = [[MGCReusableObjectQueue alloc] init];
//    _loadingDays = [NSMutableOrderedSet orderedSetWithCapacity:14];
//
//    _dimmedTimeRangesCache = [[OSCache alloc]init];
//    _dimmedTimeRangesCache.countLimit = 200;
//
//    _durationForNewTimedEvent = 60 * 60;
    
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizesSubviews = NO;
    
}



- (id)initWithCoder:(NSCoder*)coder
{
    if (self = [super initWithCoder:coder]) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}




#pragma mark - Subviews


- (UICollectionView *)allTeachersView{
    
    if (!_allTeachersView) {
        allTeacherViewFlowLayout *layout = [allTeacherViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _allTeachersView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.timedEventsViewLayout];
        _allTeachersView.backgroundColor = [UIColor clearColor];
        _allTeachersView.dataSource = self;
        _allTeachersView.delegate = self;
        _allTeachersView.showsVerticalScrollIndicator = NO;
        _allTeachersView.showsHorizontalScrollIndicator = NO;
        _allTeachersView.scrollsToTop = NO;
        _allTeachersView.decelerationRate = UIScrollViewDecelerationRateFast;
        _allTeachersView.allowsSelection = NO;
        _allTeachersView.directionalLockEnabled = YES;
        
        
        [_allTeachersView registerClass:allTeachersCollectiomCell.class forCellWithReuseIdentifier:allTeacherViewColumnIdentifier];
    }
    return _allTeachersView;
    
}

//- (UICollectionView*)timedEventsView
//{
//    if (!_timedEventsView) {
//        _timedEventsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.timedEventsViewLayout];
//        _timedEventsView.backgroundColor = [UIColor clearColor];
//        _timedEventsView.dataSource = self;
//        _timedEventsView.delegate = self;
//        _timedEventsView.showsVerticalScrollIndicator = NO;
//        _timedEventsView.showsHorizontalScrollIndicator = NO;
//        _timedEventsView.scrollsToTop = NO;
//        _timedEventsView.decelerationRate = UIScrollViewDecelerationRateFast;
//        _timedEventsView.allowsSelection = NO;
//        _timedEventsView.directionalLockEnabled = YES;
//
////        _timedEventsView.backgroundColor = [UIColor blueColor];
//
//        [_timedEventsView registerClass:MGCEventCell.class forCellWithReuseIdentifier:EventCellReuseIdentifier];
//        [_timedEventsView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:DimmingViewKind withReuseIdentifier:DimmingViewReuseIdentifier];
//        UILongPressGestureRecognizer *longPress = [UILongPressGestureRecognizer new];
////        [longPress addTarget:self action:@selector(handleLongPress:)];
////        [_timedEventsView addGestureRecognizer:longPress];
//
//        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
//        [tap addTarget:self action:@selector(handleTap:)];
//        [_timedEventsView addGestureRecognizer:tap];
//
//        UIPinchGestureRecognizer *pinch = [UIPinchGestureRecognizer new];
//        [pinch addTarget:self action:@selector(handlePinch:)];
//        [_timedEventsView addGestureRecognizer:pinch];
//    }
//    return _timedEventsView;
//}

#pragma mark - Zooming

- (void)handlePinch:(UIPinchGestureRecognizer*)gesture
{
//    if (!self.zoomingEnabled) return;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.hourSlotHeightForGesture = self.hourSlotHeight;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        if (gesture.numberOfTouches > 1) {
            CGFloat hourSlotHeight = self.hourSlotHeightForGesture * gesture.scale;
            
            if (hourSlotHeight != self.hourSlotHeight) {
                self.hourSlotHeight = hourSlotHeight;
                
//                if ([self.delegate respondsToSelector:@selector(dayPlannerViewDidZoom:)]) {
//                    [self.delegate dayPlannerViewDidZoom:self];
//                }
            }
        }
    }
}

#pragma mark - Selection

//- (void)handleTap:(UITapGestureRecognizer*)gesture
//{
//    if (gesture.state == UIGestureRecognizerStateEnded)
//    {
////        [self deselectEventWithDelegate:YES]; // deselect previous
//
//        UICollectionView *view = (UICollectionView*)gesture.view;
//        CGPoint pt = [gesture locationInView:view];
//
//        NSIndexPath *path = [view indexPathForItemAtPoint:pt];
//        if (path)  // a cell was touched
//        {
//            NSDate *date = [self dateFromDayOffset:path.section];
//            MGCEventType type = (view == self.timedEventsView) ? MGCTimedEventType : MGCAllDayEventType;
//
//            [self selectEventWithDelegate:YES type:type atIndex:path.item date:date];
//        }
//    }
//}

#pragma mark - 选择Event
// tellDelegate is used to distinguish between user selection (touch) where delegate is informed,
// and programmatically selected events where delegate is not informed
//-(void)selectEventWithDelegate:(BOOL)tellDelegate type:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
//{
////    [self deselectEventWithDelegate:tellDelegate];
//
////    if (self.allowsSelection) {
//        NSInteger section = [self dayOffsetFromDate:date];
//        NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:section];
//
//        MGCEventCell *cell = [self collectionViewCellForEventOfType:type atIndexPath:path];
//        if (cell)
//        {
//            BOOL shouldSelect = YES;
////            if (tellDelegate && [self.delegate respondsToSelector:@selector(dayPlannerView:shouldSelectEventOfType:atIndex:date:)]) {
////                shouldSelect = [self.delegate dayPlannerView:self shouldSelectEventOfType:type atIndex:index date:date];
////            }
//
//            if (shouldSelect) {
//                cell.selected = YES;
////                self.selectedCellIndexPath = path;
////                self.selectedCellType = type;
//
//                if (tellDelegate && [self.delegate respondsToSelector:@selector(dayPlannerView:didSelectEventOfType:atIndex:date:)]) {
//                    [self.delegate dayPlannerView:self didSelectEventOfType:type atIndex:path.item date:date];
//                }
//            }
//        }
////    }
//}

// returns the day offset from the first loaded day in the view (ie startDate)
- (NSInteger)dayOffsetFromDate:(NSDate*)date
{
    NSAssert(date, @"dayOffsetFromDate: was passed nil date");
    
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitDay fromDate:self.startDate toDate:date options:0];
    return comps.day;
}

- (UICollectionView*)dayColumnsView
{
    if (!_dayColumnsView) {
        MGCDayColumnViewFlowLayout *layout = [MGCDayColumnViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _dayColumnsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _dayColumnsView.backgroundColor = [UIColor clearColor];
        _dayColumnsView.dataSource = self;
        _dayColumnsView.delegate = self;
        _dayColumnsView.showsHorizontalScrollIndicator = NO;
        _dayColumnsView.decelerationRate = UIScrollViewDecelerationRateFast;
        _dayColumnsView.scrollEnabled = NO;
        _dayColumnsView.allowsSelection = NO;
        
        
        [_dayColumnsView registerClass:MGCDayColumnCell.class forCellWithReuseIdentifier:DayColumnCellReuseIdentifier];
    }
    return _dayColumnsView;
}

- (UIScrollView*)timeScrollView
{
    if (!_timeScrollView) {
        _timeScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _timeScrollView.backgroundColor = [UIColor clearColor];
        _timeScrollView.delegate = self;
        _timeScrollView.showsVerticalScrollIndicator = NO;
        _timeScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        _timeScrollView.scrollEnabled = NO;
        
        _timeRowsView = [[MGCTimeRowsView alloc]initWithFrame:CGRectZero];
        _timeRowsView.delegate = self;
        _timeRowsView.timeColor = self.timeSeparatorsColor;
        _timeRowsView.currentTimeColor = [UIColor redColor];
        _timeRowsView.hourSlotHeight = self.hourSlotHeight;
        _timeRowsView.hourRange = self.hourRange;
        _timeRowsView.insetsHeight = self.eventsViewInnerMargin;
        _timeRowsView.timeColumnWidth = self.timeColumnWidth;
        _timeRowsView.contentMode = UIViewContentModeRedraw;
        [_timeScrollView addSubview:_timeRowsView];
    }
    return _timeScrollView;
}


//- (UIView*)allDayEventsBackgroundView
//{
//    if (!_allDayEventsBackgroundView) {
//        _allDayEventsBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//        _allDayEventsBackgroundView.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.83 alpha:1.];
//        _allDayEventsBackgroundView.clipsToBounds = YES;
//        _allDayEventsBackgroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _allDayEventsBackgroundView.layer.borderWidth = 1;
//    }
//    return _allDayEventsBackgroundView;
//}


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

// public
- (CGSize)dayColumnSize
{
    CGFloat height = self.hourSlotHeight * self.hourRange.length + 2 * self.eventsViewInnerMargin;
    
    // if the number of days in dateRange is less than numberOfVisibleDays, spread the days over the view
    NSUInteger numberOfDays = 7;
    CGFloat width = 200; //(self.bounds.size.width - self.timeColumnWidth) / numberOfDays;
    
    return MGCAlignedSizeMake(width, height);
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
//    if (collectionView == self.timedEventsView) {
//        return 3; //[self.dataSource dayPlannerView:self numberOfEventsOfType:MGCTimedEventType atDate:date];
//    }
    return 1; // for dayColumnView
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 7;//self.numberOfLoadedDays;
}

- (UICollectionViewCell*)dayColumnCellAtIndexPath:(NSIndexPath*)indexPath
{
    MGCDayColumnCell *dayCell = [self.dayColumnsView dequeueReusableCellWithReuseIdentifier:DayColumnCellReuseIdentifier forIndexPath:indexPath];
    dayCell.headerHeight = self.dayHeaderHeight;
    dayCell.separatorColor = [UIColor blueColor];
    dayCell.dotColor = [UIColor redColor];
    
//    dayCell.backgroundColor = [UIColor orangeColor];
    
//    NSDate *date = [self dateFromDayOffset:indexPath.section];
//
//    NSUInteger weekDay = [self.calendar components:NSCalendarUnitWeekday fromDate:date].weekday;
//    NSUInteger accessoryTypes = weekDay == self.calendar.firstWeekday ? MGCDayColumnCellAccessorySeparator : MGCDayColumnCellAccessoryBorder;
//
//    NSAttributedString *attrStr = nil;
//    if ([self.delegate respondsToSelector:@selector(dayPlannerView:attributedStringForDayHeaderAtDate:)]) {
//        attrStr = [self.delegate dayPlannerView:self attributedStringForDayHeaderAtDate:date];
//    }
//
//    if (attrStr) {
//        dayCell.dayLabel.attributedText = attrStr;
//    }
//    else {
//
//        static NSDateFormatter *dateFormatter = nil;
//        if (dateFormatter == nil) {
//            dateFormatter = [NSDateFormatter new];
//        }
//        dateFormatter.dateFormat = self.dateFormat ?: @"d MMM\neeeee";
//
//        NSString *s = [dateFormatter stringFromDate:date];
//
//        NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
//        para.alignment = NSTextAlignmentCenter;
//
//        UIFont *font = [UIFont systemFontOfSize:14];
//        UIColor *color = [self.calendar isDateInWeekend:date] ? [UIColor lightGrayColor] : [UIColor blackColor];
//
//        if ([self.calendar mgc_isDate:date sameDayAsDate:[NSDate date]]) {
//            accessoryTypes |= MGCDayColumnCellAccessoryMark;
//            dayCell.markColor = self.tintColor;
//            color = [UIColor whiteColor];
//            font = [UIFont boldSystemFontOfSize:14];
//        }
//
//        NSAttributedString *as = [[NSAttributedString alloc]initWithString:s attributes:@{ NSParagraphStyleAttributeName: para, NSFontAttributeName: font, NSForegroundColorAttributeName: color }];
//        dayCell.dayLabel.attributedText = as;
    
    dayCell.dayLabel.text = [NSString stringWithFormat:@"星期%ld（年月日）",indexPath.section];
    
//    }
    
//    if ([self.loadingDays containsObject:date]) {
//        [dayCell setActivityIndicatorVisible:YES];
//    }
//
//    NSUInteger count = [self numberOfAllDayEventsAtDate:date] + [self numberOfTimedEventsAtDate:date];
//    if (count > 0) {
//        accessoryTypes |= MGCDayColumnCellAccessoryDot;
//    }
//
    dayCell.accessoryTypes = 0;
    return dayCell;
}

//- (UICollectionViewCell*)dequeueCellForEventOfType:(MGCEventType)type atIndexPath:(NSIndexPath*)indexPath
//{
//    NSDate *date = nil; //[self dateFromDayOffset:indexPath.section];
//    NSUInteger index = indexPath.item;
//    MGCEventView *cell = [self dayPlannerView:self viewForEventOfType:type atIndex:index date:date];
//
//    MGCEventCell *cvCell = nil;
//    if (type == MGCTimedEventType) {
//        cvCell = (MGCEventCell*)[self.timedEventsView dequeueReusableCellWithReuseIdentifier:EventCellReuseIdentifier forIndexPath:indexPath];
//    }
//    cvCell.backgroundColor = [UIColor redColor];
//    cvCell.eventView = cell;
////    if ([self.selectedCellIndexPath isEqual:indexPath] && self.selectedCellType == type) {
////        cvCell.selected = YES;
////    }
//
//    return cvCell;
//}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
//    if (collectionView == self.timedEventsView) {
//        return [self dequeueCellForEventOfType:MGCTimedEventType atIndexPath:indexPath];
//    }
//    else if (collectionView == self.allDayEventsView) {
//        return [self dequeueCellForEventOfType:MGCAllDayEventType atIndexPath:indexPath];
//    }
    if (collectionView == self.dayColumnsView) {
        return [self dayColumnCellAtIndexPath:indexPath];
    }else{
        //事件一级view
        
        allTeachersCollectiomCell *Cell = [self.allTeachersView dequeueReusableCellWithReuseIdentifier:allTeacherViewColumnIdentifier forIndexPath:indexPath];
        Cell.dayColumnSize = self.dayColumnSize;
        Cell.hourSlotHeight = self.hourSlotHeight;
        Cell.eventsViewInnerMargin = self.eventsViewInnerMargin;
//        Cell.teahersData =
        
        return Cell;
        
    }
    return nil;
}

- (UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath
{
//    if ([kind isEqualToString:DimmingViewKind]) {
        UICollectionReusableView *view = [self.allTeachersView dequeueReusableSupplementaryViewOfKind:DimmingViewKind withReuseIdentifier:DimmingViewReuseIdentifier forIndexPath:indexPath];
        view.backgroundColor = [UIColor grayColor]; //self.dimmingColor;
        
        return view;
//    }
//    ///// test
//    else if ([kind isEqualToString:MoreEventsViewKind]) {
//        UICollectionReusableView *view = [self.allDayEventsView dequeueReusableSupplementaryViewOfKind:MoreEventsViewKind withReuseIdentifier:MoreEventsViewReuseIdentifier forIndexPath:indexPath];
//
//        view.autoresizesSubviews = YES;
//
//        NSUInteger hiddenCount = [self.allDayEventsViewLayout numberOfHiddenEventsInSection:indexPath.section];
//        UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
//        label.text = [NSString stringWithFormat:NSLocalizedString(@"%d more...", nil), hiddenCount];
//        label.textColor = [UIColor blackColor];
//        label.font = [UIFont systemFontOfSize:11];
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//
//        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        [view addSubview:label];
//
//        return view;
//    }
    return nil;
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



//- (MGCEventView*)dayPlannerView:(WeekClasstable *)view viewForEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
//{
////    EKEvent *ev = [self eventOfType:type atIndex:index date:date];
//
//    MGCStandardEventView *evCell = (MGCStandardEventView*)[view dequeueReusableViewWithIdentifier:EventCellReuseIdentifier forEventOfType:type atIndex:index date:date];
//    evCell.font = [UIFont systemFontOfSize:11];
//    evCell.title = @"课程"; //ev.title;
//    evCell.subtitle = @"详情"; //ev.location;
//    evCell.color = [UIColor colorWithCGColor:[UIColor orangeColor].CGColor];
//    evCell.style = MGCStandardEventViewStylePlain|MGCStandardEventViewStyleSubtitle;
//    evCell.style |= (type == MGCAllDayEventType) ?: MGCStandardEventViewStyleBorder;
//    return evCell;
//}
//
//- (MGCEventView*)dequeueReusableViewWithIdentifier:(NSString*)identifier forEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
//{
//    return (MGCEventView*)[self.reuseQueue dequeueReusableObjectWithReuseIdentifier:identifier];
//}




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

- (MGCDateRange*)dayPlannerView:(WeekClasstable*)view dateRangeForEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
#pragma mark - 获取课程 并返回开始结束时间
    
//    EKEvent *ev = [self eventOfType:type atIndex:index date:date];
    

    
    return [MGCDateRange dateRangeWithStart: [NSDate date] end:[NSDate dateWithTimeIntervalSinceNow:40 * 60] ];//ev.startDate end:ev.endDate];
}

// returns the scrollable time range for the day at date, depending on hourRange
- (MGCDateRange*)scrollableTimeRangeForDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *dayRangeStart = [calendar dateBySettingHour:self.hourRange.location minute:0 second:0 ofDate:date options:0];
    NSDate *dayRangeEnd = [calendar dateBySettingHour:NSMaxRange(self.hourRange) - 1 minute:59 second:0 ofDate:date options:0];
    return [MGCDateRange dateRangeWithStart:dayRangeStart end:dayRangeEnd];
}

// dayOffset is the offset from the first loaded day in the view (ie startDate)
- (NSDate*)dateFromDayOffset:(NSInteger)dayOffset
{
    NSDateComponents *comp = [NSDateComponents new];
    comp.day = dayOffset;
    return [self.calendar dateByAddingComponents:comp toDate:self.startDate options:0];
}

- (NSDate *)startDate{
    
    if (_startDate == nil) {
        
        
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                             fromDate:now];
        
        // 得到星期几
        // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
        NSInteger weekDay = [comp weekday];
        // 得到几号
        NSInteger day = [comp day];
        
        NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
        
        // 计算当前日期和这周的星期一和星期天差的天数
        long firstDiff,lastDiff;
        if (weekDay == 1) {
            firstDiff = 1;
            lastDiff = 0;
        }else{
            firstDiff = [calendar firstWeekday] - weekDay;
            lastDiff = 9 - weekDay;
        }
        
        NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
        
        // 在当前日期(去掉了时分秒)基础上加上差的天数
        NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
        [firstDayComp setDay:day + firstDiff];
        NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
        
        NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
        [lastDayComp setDay:day + lastDiff];
        NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"星期一开始 %@",[formater stringFromDate:firstDayOfWeek]);
        NSLog(@"当前 %@",[formater stringFromDate:now]);
        NSLog(@"星期天结束 %@",[formater stringFromDate:lastDayOfWeek]);
                                                                                           
        _startDate = firstDayOfWeek;
    }
    return _startDate;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    //NSLog(@"scrollViewWillBeginDragging");
    
    // direction will be determined on first scrollViewDidScroll: received
    [self scrollViewWillStartScrolling:scrollView direction:ScrollDirectionUnknown];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollview
{
    // avoid looping
    if (scrollview != self.controllingScrollView)
        return;
    
//    NSLog(@"x=---------%f",scrollview.contentOffset.x);
    NSLog(@"y=---------%f",scrollview.contentOffset.y);
    
    NSLog(@"scrollViewDidScroll");
    
    [self lockScrollingDirection];
    
    if (self.scrollDirection & ScrollDirectionHorizontal) {
        [self recenterIfNeeded];
    }
    
    [self synchronizeScrolling];
    
//    [self updateVisibleDaysRange];
    
//    if ([self.delegate respondsToSelector:@selector(dayPlannerView:didScroll:)]) {
//        MGCDayPlannerScrollType type = self.scrollDirection == ScrollDirectionHorizontal ? MGCDayPlannerScrollDate : MGCDayPlannerScrollTime;
//        [self.delegate dayPlannerView:self didScroll:type];
//    }
}


- (void)scrollViewWillStartScrolling:(UIScrollView*)scrollView direction:(ScrollDirection)direction
{
    NSAssert(scrollView == self.allTeachersView , @"For synchronizing purposes, only timedEventsView or allDayEventsView are allowed to scroll");
    
    if (self.controllingScrollView) {
        NSAssert(scrollView == self.controllingScrollView, @"Scrolling on two different views at the same time is not allowed");
        
        // we might be dragging while decelerating on the same view, but scrolling will be
        // locked according to the initial axis
    }
    
    //NSLog(@"scrollViewWillStartScrolling direction: %d", (int)direction);
    
    //[self deselectEventWithDelegate:YES];
    
    if (self.controllingScrollView == nil) {
        // we have to restrict dragging to one view at a time
        // until the whole scroll operation finishes.
        
        if (scrollView == self.allTeachersView) {

        }
        
        // note which view started scrolling - for synchronizing,
        // and the start offset in order to determine direction
        self.controllingScrollView = scrollView;
        self.scrollStartOffset = scrollView.contentOffset;
        self.scrollDirection = direction;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    //NSLog(@"scrollViewDidEndDragging decelerate: %d", decelerate);
    
    // (decelerate = NO and scrollView.decelerating = YES) means that a second scroll operation
    // started on the same scrollview while decelerating.
    // in that (rare) case, don't end up the operation, which could mess things up.
    // ex: swipe vertically and soon after swipe forward
    
    if (!decelerate && !scrollView.decelerating) {
        [self scrollViewDidEndScrolling:scrollView];
    }
    
    if (decelerate) {
        [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    //NSLog(@"scrollViewDidEndDecelerating");
    
    [self scrollViewDidEndScrolling:scrollView];
    
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView
{
    //NSLog(@"scrollViewDidEndScrollingAnimation");
    
    [self scrollViewDidEndScrolling:scrollView];
    
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
}


// even though directionalLockEnabled is set on both scrolling-enabled scrollviews,
// one can still scroll diagonally if the scrollview is dragged in both directions at the same time.
// This is not what we want!
- (void)lockScrollingDirection
{
    NSAssert(self.controllingScrollView, @"Trying to lock scrolling direction while no scroll operation has started");
    
    CGPoint contentOffset = self.controllingScrollView.contentOffset;
    if (self.scrollDirection == ScrollDirectionUnknown) {
        // determine direction
        if (fabs(self.scrollStartOffset.x - contentOffset.x) < fabs(self.scrollStartOffset.y - contentOffset.y)) {
            self.scrollDirection = ScrollDirectionVertical;
        }
        else {
            self.scrollDirection = ScrollDirectionHorizontal;
        }
    }
    
    // lock scroll position of the scrollview according to detected direction
    if (self.scrollDirection & ScrollDirectionVertical) {
        [self.controllingScrollView    setContentOffset:CGPointMake(self.scrollStartOffset.x, contentOffset.y)];
    }
    else if (self.scrollDirection & ScrollDirectionHorizontal) {
        [self.controllingScrollView setContentOffset:CGPointMake(contentOffset.x, self.scrollStartOffset.y)];
    }
}

// if necessary, recenters horizontally the controlling scroll view to permit infinite scrolling.
// this is called by scrollViewDidScroll:
// returns YES if we loaded new pages, NO otherwise
- (BOOL)recenterIfNeeded
{
    NSAssert(self.controllingScrollView, @"Trying to recenter with no controlling scroll view");
    
    CGFloat xOffset = self.controllingScrollView.contentOffset.x;
    CGFloat xContentSize = self.controllingScrollView.contentSize.width;
    CGFloat xPageSize = self.controllingScrollView.bounds.size.width;
    
    // this could eventually be tweaked - for now we recenter when we have less than a page on one or the other side
//    if (xOffset < xPageSize || xOffset + 2 * xPageSize > xContentSize) {
//        NSDate *newStart = [self startDateForFirstVisibleDate:self.visibleDays.start dayOffset:nil];
//        NSInteger diff = [self.calendar components:NSCalendarUnitDay fromDate:self.startDate toDate:newStart options:0].day;
//
//        if (diff != 0) {
//            self.startDate = newStart;
//            [self reloadCollectionViews];
//
//            CGFloat newXOffset = -diff * self.dayColumnSize.width + self.controllingScrollView.contentOffset.x;
//            [self.controllingScrollView setContentOffset:CGPointMake(newXOffset, self.controllingScrollView.contentOffset.y)];
//            return YES;
//        }
//    }
    return NO;
}

// this is called by scrollViewDidScroll: to synchronize the collections views
// vertically (timedEventsView with timeRowsView), and horizontally (allDayEventsView with timedEventsView and dayColumnsView)
- (void)synchronizeScrolling
{
    NSAssert(self.controllingScrollView, @"Synchronizing scrolling with no controlling scroll view");
    
    CGPoint contentOffset = self.controllingScrollView.contentOffset;
    
     if (self.controllingScrollView == self.allTeachersView) {
        
        if (self.scrollDirection & ScrollDirectionHorizontal) {
            self.dayColumnsView.contentOffset = CGPointMake(contentOffset.x, 0);
        }
        else {
            self.timeScrollView.contentOffset = CGPointMake(0, contentOffset.y);
        }
    }
}


// this is called at the end of every scrolling operation, initiated by user or programatically
- (void)scrollViewDidEndScrolling:(UIScrollView*)scrollView
{
    //NSLog(@"scrollViewDidEndScrolling");
    
    // reset everything
    if (scrollView == self.controllingScrollView) {
        ScrollDirection direction = self.scrollDirection;
        
        self.scrollDirection = ScrollDirectionUnknown;
        self.allTeachersView.scrollEnabled = YES;
        self.controllingScrollView = nil;
        
//        if (self.scrollViewAnimationCompletionBlock) {
//            dispatch_async(dispatch_get_main_queue(), self.scrollViewAnimationCompletionBlock);
//            self.scrollViewAnimationCompletionBlock =  nil;
//        }
        
        if (direction == ScrollDirectionHorizontal) {
            [self setupSubviews];  // allDayEventsView might need to be resized
        }
        
//        if ([self.delegate respondsToSelector:@selector(dayPlannerView:didEndScrolling:)]) {
//            MGCDayPlannerScrollType type = direction == ScrollDirectionHorizontal ? MGCDayPlannerScrollDate : MGCDayPlannerScrollTime;
//            [self.delegate dayPlannerView:self didEndScrolling:type];
//        }
    }
}



//// public
//- (MGCDateRange*)visibleDays
//{
//    CGFloat dayWidth = self.dayColumnSize.width;
//
//    NSUInteger first = floorf(self.timedEventsView.contentOffset.x / dayWidth);
//    NSDate *firstDay = [self dateFromDayOffset:first];
//    if (self.dateRange && [firstDay compare:self.dateRange.start] == NSOrderedAscending)
//        firstDay = self.dateRange.start;
//
//    // since the day column width is rounded, there can be a difference of a few points between
//    // the right side of the view bounds and the limit of the last column, causing last visible day
//    // to be one more than expected. We have to take this in account
//    CGFloat diff = self.timedEventsView.bounds.size.width - self.dayColumnSize.width * self.numberOfVisibleDays;
//
//    NSUInteger last = ceilf((CGRectGetMaxX(self.timedEventsView.bounds) - diff) / dayWidth);
//    NSDate *lastDay = [self dateFromDayOffset:last];
//    if (self.dateRange && [lastDay compare:self.dateRange.end] != NSOrderedAscending)
//        lastDay = self.dateRange.end;
//
//    return [MGCDateRange dateRangeWithStart:firstDay end:lastDay];
//}


// public
- (NSCalendar*)calendar
{
    if (_calendar == nil) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.allTeachersView) {
        
        CGSize allteacherColumnSize = self.dayColumnSize;
        return CGSizeMake(allteacherColumnSize.width, self.bounds.size.height - self.dayHeaderHeight);
    }
    
    CGSize dayColumnSize = self.dayColumnSize;
    return CGSizeMake(dayColumnSize.width, self.bounds.size.height);
    
}

@end
