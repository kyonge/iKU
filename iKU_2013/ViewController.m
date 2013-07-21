//
//  ViewController.m
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSubViews];
}

- (void)viewDidLayoutSubviews
{
    [self loadMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 초기화

#pragma mark 메뉴 로드

- (void)loadMenu
{
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (menuButtonWidth + menuButtonMargin) * menuCount + menuButtonMargin, 60)];
    
    CGFloat tempOriginX;
    
    for (int i = 0; i < menuCount; i++) {
        UIButton *tempMenuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        tempOriginX = menuButtonMargin + (menuButtonWidth + menuButtonMargin) * i;
        [tempMenuButton setFrame:CGRectMake(tempOriginX, 0, menuButtonWidth, 60)];
        [tempMenuButton setTag:i + 1];
        [tempMenuButton addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        
        [menuView addSubview:tempMenuButton];
    }
    
    [menuScrollView addSubview:menuView];
    [menuScrollView setContentSize:[menuView frame].size];
}

#pragma mark 서브뷰 로드

- (void)loadSubViews
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    noticeViewController = [storyboard instantiateViewControllerWithIdentifier:@"IKNoticeViewController"];
    scheduleViewController = [IKScheduleViewController new];
    ekuViewController = [IKEKUViewController new];
    
    [[noticeViewController view] setFrame:CGRectMake(0, 0, 320, [contentsView frame].size.height)];
    [[scheduleViewController view] setFrame:CGRectMake(0, 0, 320, [contentsView frame].size.height)];
    
    [contentsView addSubview:[noticeViewController view]];
    [contentsView addSubview:[scheduleViewController view]];
    [contentsView addSubview:[ekuViewController view]];
    
    [noticeViewController showView];
    [scheduleViewController hideView];
    [ekuViewController hideView];
}


#pragma mark - 탭 선택

- (void)hideAllSubViews
{
    [noticeViewController hideView];
    [scheduleViewController hideView];
    [ekuViewController hideView];
}

- (void)selectTab:(id)sender
{
    enum IKTab senderTag = (enum IKTab)[sender tag];
    
    [self hideAllSubViews];
    
    if (senderTag == IKTab1_Notice) {
        [noticeViewController showView];
    }
    else if (senderTag == IKTab2_Schedule) {
        [scheduleViewController showView];
    }
    else if (senderTag == IKTab3_EKU) {
        
    }
}

@end
