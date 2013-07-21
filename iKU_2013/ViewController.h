//
//  ViewController.h
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IKNoticeViewController.h"
#import "IKScheduleViewController.h"
#import "IKEKUViewController.h"

#define menuCount 3
#define menuButtonWidth 60
#define menuButtonMargin 5

enum IKTab {
    IKTab1_Notice = 1,
    IKTab2_Schedule = 2,
    IKTab3_EKU = 3
};

@interface ViewController : UIViewController {
    IBOutlet UIScrollView *menuScrollView;
    IBOutlet UIView *contentsView;
    
    IKNoticeViewController *noticeViewController;
    IKScheduleViewController *scheduleViewController;
    IKEKUViewController *ekuViewController;
}

@end
