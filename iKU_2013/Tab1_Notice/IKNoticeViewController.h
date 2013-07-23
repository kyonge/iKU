//
//  IKNoticeViewController.h
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ETUtility.h"
#import "IKNoticeLoader.h"
#import "IKNoticeCell.h"

#import "IKSubViewController.h"

@interface IKNoticeViewController : IKSubViewController <IKNoticeLoaderDelegate, UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UIButton *noticeButton1, *noticeButton2, *noticeButton3, *noticeButton4;
    IBOutlet UITableView *noticeListTableView;
    
    NSMutableArray *noticeListArray;
}

#pragma mark - 탭 선택
- (IBAction)selectTab:(id)sender;

@end
