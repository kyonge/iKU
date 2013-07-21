//
//  IKCalendarDateButton.h
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKCalendarDateButton : UIButton {
    BOOL dateSelected;
}

- (void)initCalendarButton;
- (void)onDot;
- (void)offDot;

@property (assign, readwrite) BOOL dateSelected;

@end
