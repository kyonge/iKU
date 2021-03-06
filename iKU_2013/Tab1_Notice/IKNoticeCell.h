//
//  IKNoticeCell.h
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKNoticeCell : UITableViewCell {
    IBOutlet UILabel *noticeIndexLabel;
    IBOutlet UILabel *noticeTitleLabel;
    IBOutlet UILabel *noticeDateLabel;
    
    NSString *noticeUrlString;
}

@property (readwrite) UILabel *noticeIndexLabel;
@property (readwrite) UILabel *noticeTitleLabel;
@property (readwrite) UILabel *noticeDateLabel;
@property (readwrite) NSString *noticeUrlString;

@end
