//
//  IKScheduleViewController.h
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ETUtility.h"

#import "IKCalendarDateButton.h"

#import "IKSubViewController.h"

@interface IKScheduleViewController : IKSubViewController {
    IBOutlet UILabel *dateMonthLabel, *dateDayLabel;
    IBOutlet UIView *calendarView;
    IBOutlet UITableView *scheduleTableView;
    
    NSMutableArray *dateButtonArray;
    
    NSDate *curDate;
    
    NSInteger firstWeekDayOfMonth;
    NSInteger totalDaysOfMonth;
    NSInteger clickedDate;
}

#pragma mark - 달 변경
- (IBAction)prevMonth:(id)sender;
- (IBAction)nextMonth:(id)sender;

#pragma mark - 일 변경
- (IBAction)selectToday:(id)sender;

@end
