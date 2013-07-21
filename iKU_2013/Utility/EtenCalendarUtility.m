//
//  EtenCalendarUtility.m
//  FashionDiary
//
//  Created by 기용 이 on 13. 2. 20..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import "EtenCalendarUtility.h"

@implementation EtenCalendarUtility

#pragma mark 달력 유틸리티 메서드

+ (NSString*)dateString:(NSDate*)date format:(NSString*)format {
	NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
	[fmt setTimeStyle:NSDateFormatterNoStyle];
	[fmt setDateFormat:format];
	NSString *s = [fmt stringFromDate:date];
    
	return s;
}

+ (NSArray *)datetimeObject:(NSDate *)stDate
{
    NSString *strDate = [EtenCalendarUtility dateString:stDate format:@"yyyy:MM:dd:HH:mm:SS"];
    NSArray *arrDate = [strDate componentsSeparatedByString:@":"];
    
    if ([arrDate count] == 6) {
        return arrDate;
    }
    
    return nil;
}

+ (NSInteger) valueforDate:(NSDate *)stDate Key:(NSInteger)key
{
    NSInteger result = [[[EtenCalendarUtility datetimeObject:stDate] objectAtIndex:key] intValue];
    
    return result;
}

+ (NSInteger)LeapYearCalculation:(NSInteger)year
{
    if ((((year%4)==0) && ((year%100)!=0)) || ((year%400)==0)){
        return 29;
    }
    
    return 28;
}

+ (NSInteger)MonthDays:(NSDate *)inDate
{
    NSInteger year = [EtenCalendarUtility valueforDate:inDate Key:0];
    NSInteger month = [EtenCalendarUtility valueforDate:inDate Key:1];
    
    if (month == 2) {
        return [EtenCalendarUtility LeapYearCalculation:year];
    }
    else if (month == 7) {
        return 31;
    }
    else if(((month%7)%2) == 0) {
        return 30;
    }
    
    return 31;
}

+ (NSInteger) totalMonths:(NSDate *)stDate end:(NSDate *)edDate
{
    NSInteger stMonth;
    NSInteger edMonth;
    NSInteger result;
    
    if (!edDate) {
        edDate = [NSDate date];
    }
    
    stMonth = ([[[EtenCalendarUtility datetimeObject:stDate] objectAtIndex:0]intValue] * 12) +
    ([[[EtenCalendarUtility datetimeObject:stDate] objectAtIndex:1]intValue]);
    edMonth = ([[[EtenCalendarUtility datetimeObject:edDate] objectAtIndex:0]intValue] * 12) +
    ([[[EtenCalendarUtility datetimeObject:edDate] objectAtIndex:1]intValue]);
    
    result = edMonth - stMonth;
    
    return result;
}

@end
