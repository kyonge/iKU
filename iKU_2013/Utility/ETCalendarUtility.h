//
//  ETCalendarUtility.h
//  FashionDiary
//
//  Created by 기용 이 on 13. 2. 20..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETCalendarUtility : NSObject

#pragma mark 달력 유틸리티 메서드

+ (NSString *)dateString:(NSDate*)date format:(NSString*)format;
+ (NSArray *)datetimeObject:(NSDate *)stDate;
+ (NSInteger)valueforDate:(NSDate *)stDate Key:(NSInteger)key;
+ (NSInteger)LeapYearCalculation:(NSInteger)year;
+ (NSInteger)MonthDays:(NSDate *)inDate;
+ (NSInteger)totalMonths:(NSDate *)stDate end:(NSDate *)edDate;

@end
