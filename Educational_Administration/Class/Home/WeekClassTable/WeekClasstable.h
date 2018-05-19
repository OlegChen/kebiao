//
//  WeekClasstable.h
//  Educational_Administration
//
//  Created by Apple on 2018/5/10.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MGCTimedEventsViewLayout.h"



typedef NS_ENUM(NSUInteger, MGCEventType) {
    MGCAllDayEventType = 0,
    MGCTimedEventType
};

// used to restrict scrolling to one direction / axis
typedef enum: NSUInteger
{
    ScrollDirectionUnknown = 0,
    ScrollDirectionLeft = 1 << 0,
    ScrollDirectionUp = 1 << 1,
    ScrollDirectionRight = 1 << 2,
    ScrollDirectionDown = 1 << 3,
    ScrollDirectionHorizontal = (ScrollDirectionLeft | ScrollDirectionRight),
    ScrollDirectionVertical = (ScrollDirectionUp | ScrollDirectionDown)
} ScrollDirection;

typedef NS_ENUM(NSUInteger, MGCDayPlannerTimeMark) {
    MGCDayPlannerTimeMarkHeader = 0,
    MGCDayPlannerTimeMarkCurrent = 1,
    MGCDayPlannerTimeMarkFloating = 2,
};


@protocol weekClassTableDelegate;


@interface WeekClasstable : UIView

@property (nonatomic, readonly) CGSize dayColumnSize;



@property (nonatomic) CGFloat hourSlotHeight;

/*!
 @abstract    Returns the width of the left column showing hours.
 @discussion The default value is 60.
 To hide the time column, you can set this value to 0.
 */
@property (nonatomic) CGFloat timeColumnWidth;

/*!
 @abstract    Returns the height of the top row showing days.
 @discussion The default value is 40.
 To hide the day header, you can set this value to 0.
 */
@property (nonatomic) CGFloat dayHeaderHeight;


/*!
 @abstract    Returns the color of the vertical separator lines between days.
 @discussion The default value is light gray.
 */
@property (nonatomic) UIColor *daySeparatorsColor;

/*!
 @abstract    Returns the color of the horizontal separator lines between time slots.
 @discussion The default value is light gray.
 The color is also used for time labels.
 @see        dayPlannerView:attributedStringForTimeMark:time: delegate method
 */
@property (nonatomic) UIColor *timeSeparatorsColor;


/*!
 @abstract    Displayable range of hours. Default is {0, 24}.
 @discussion Range length must be >= 1
 
 */
@property (nonatomic) NSRange hourRange;


@property (nonatomic, weak) id<weekClassTableDelegate> delegate;


@end


@protocol weekClassTableDelegate<NSObject>

@optional


- (void)dayPlannerView:(WeekClasstable*)view didSelectEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date;

@end
