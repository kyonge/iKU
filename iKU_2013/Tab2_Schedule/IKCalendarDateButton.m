//
//  IKCalendarDateButton.m
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import "IKCalendarDateButton.h"

@implementation IKCalendarDateButton

@synthesize dateSelected;

- (void)initCalendarButton {
    UIView *tempDotView = [[UIView alloc] initWithFrame:CGRectMake(19, 29, 4, 4)];
    [tempDotView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:tempDotView];
    [tempDotView setHidden:YES];
}

- (void)onDot
{
    UIView *tempDotView = [[self subviews] lastObject];
    [tempDotView setHidden:NO];
}

- (void)offDot
{
    UIView *tempDotView = [[self subviews] lastObject];
    [tempDotView setHidden:YES];
}

@end
