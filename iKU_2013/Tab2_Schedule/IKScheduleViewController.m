//
//  IKScheduleViewController.m
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import "IKScheduleViewController.h"

@interface IKScheduleViewController ()

@end

@implementation IKScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initButtonArrayFirstTime];
    [self initCalendar:[NSDate date]];
    
    [self initTableViewSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 초기화

- (void)initTableViewSize
{
    if ([ETUtility is4Inch]) [scheduleTableView setFrame:CGRectMake(5, 326, 310, 156)];
    else [scheduleTableView setFrame:CGRectMake(5, 326, 310, 67)];
}


#pragma mark - 달력 초기화

- (void)initButtonArrayFirstTime
{
    dateButtonArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 43; i++) {
        IKCalendarDateButton *tempDateButton = [[calendarView subviews] objectAtIndex:i];
        [tempDateButton initCalendarButton];
    }
    
    [self initButtonArray];
}

- (void)initButtonArray
{
    dateButtonArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 43; i++) {
        IKCalendarDateButton *tempDateButton = [[calendarView subviews] objectAtIndex:i];
        [tempDateButton addTarget:self action:@selector(clickDateButton:) forControlEvents:UIControlEventTouchUpInside];
        [tempDateButton setTitle:@"" forState:UIControlStateNormal];
        [tempDateButton offDot];
        [tempDateButton setTag:100];
        if (![dateButtonArray containsObject:tempDateButton])
            [dateButtonArray addObject:tempDateButton];
    }
    
    [self clearDateButtons];
}

- (void)clearDateButtons
{
    for (int i = 1; i < 43; i++) {
        IKCalendarDateButton *tempDateButton = [[calendarView subviews] objectAtIndex:i];
        [tempDateButton setBackgroundColor:[UIColor clearColor]];
        [tempDateButton setAlpha:1.0];
        [tempDateButton setDateSelected:NO];
    }
}

- (void)clearDateButtonDots
{
    for (int i = 1; i < 43; i++) {
        IKCalendarDateButton *tempDateButton = [[calendarView subviews] objectAtIndex:i];
        [tempDateButton offDot];
    }
}


#pragma mark - 달력 표기

- (void)initCalendar:(NSDate *)date
{
    curDate = date;
    
    NSCalendar *nsCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [nsCalendar components:unitFlags fromDate:curDate];
    
    int dateYear = [dateComponents year];
    int dateMonth = [dateComponents month];
    int dateDay = [dateComponents day];
    
    [dateMonthLabel setText:[NSString stringWithFormat:@"%d월 %d", dateMonth, dateYear]];
    [dateDayLabel setText:[NSString stringWithFormat:@"%d년 %d월 %d일", dateYear, dateMonth, dateDay]];
    
    NSDate *firstDate = [NSDate dateWithTimeInterval:(dateDay - 1) * 24 * 60 * 60 * (-1) sinceDate:date];
    
    NSDateComponents *firstDayComponents = [nsCalendar components:unitFlags fromDate:firstDate];
    int date1WeekDay = [firstDayComponents weekday];
    firstWeekDayOfMonth = date1WeekDay - 1;
    
    totalDaysOfMonth = [ETCalendarUtility MonthDays:date];
    
    for (int i = firstWeekDayOfMonth, j = 0; i < firstWeekDayOfMonth + totalDaysOfMonth; i++, j++) {
        IKCalendarDateButton *firstDateButton = [dateButtonArray objectAtIndex:i];
        [firstDateButton setTag:j];
        [firstDateButton setTitle:[NSString stringWithFormat:@"%d", j + 1] forState:UIControlStateNormal];
    }
    
    [self checkDots];
    
    [self setDay:dateDay - 1];
}

- (void)checkDots
{
    //일정 체크
    
//    [tempDateButton onDot];
}


#pragma mark - 달 변경

- (IBAction)prevMonth:(id)sender
{
    NSCalendar *nsCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [nsCalendar components:unitFlags fromDate:curDate];
    int dateDay = [dateComponents day];
    
    NSTimeInterval newValue = 60 * 60 * 24 * dateDay;
    curDate = [NSDate dateWithTimeInterval:(-1) * newValue sinceDate:curDate];
    
    [self changeCalendar:curDate];
}

- (IBAction)nextMonth:(id)sender
{
    NSCalendar *nsCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [nsCalendar components:unitFlags fromDate:curDate];
    int dateDay = [dateComponents day];
    
    NSTimeInterval newValue = 60 * 60 * 24 * (totalDaysOfMonth - dateDay + 1);
    curDate = [NSDate dateWithTimeInterval:newValue sinceDate:curDate];
    
    [self changeCalendar:curDate];
}

- (void)changeCalendar:(NSDate *)date
{
    [self initButtonArray];
    [self initCalendar:date];
}


#pragma mark - 일 변경

- (IBAction)selectToday:(id)sender
{
    [self clearDateButtons];
    [self clearDateButtonDots];
    
    [self initCalendar:[NSDate date]];
}

- (void)clickDateButton:(IKCalendarDateButton *)sender
{
    [self clearDateButtons];
    
    int tag = [sender tag];
    if (tag != 100) {
        [self setDay:tag];
    }
}

- (void)setDay:(int)day
{
    int realDay = day + 1;
    
    NSCalendar *nsCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [nsCalendar components:unitFlags fromDate:curDate];
    
    int dateYear = [dateComponents year];
    int dateMonth = [dateComponents month];
    
    //라벨, 버튼
    [dateDayLabel setText:[NSString stringWithFormat:@"%d년 %d월 %d일", dateYear, dateMonth, realDay]];
    IKCalendarDateButton *tempDateButton = [dateButtonArray objectAtIndex:firstWeekDayOfMonth + day];
    [tempDateButton setBackgroundColor:[UIColor yellowColor]];
    [tempDateButton setAlpha:0.5];
    [tempDateButton setDateSelected:YES];
}

@end
