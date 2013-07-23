//
//  IKNoticeLoader.h
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 23..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMLNode.h"
#import "HTMLParser.h"

enum IKNoticeType {
    IKNoticeType1_E = 1,
    IKNoticeType2_NG = 2,
    IKNoticeType3_R = 3,
    IKNoticeType4_J = 4
};


@protocol IKNoticeLoaderDelegate <NSObject>

- (void)noticeListLoaded:(NSMutableArray *)noticeList;

@end


@interface IKNoticeLoader : NSObject {
    NSMutableArray *boardListArray;
    
    enum IKNoticeType noticeType;
    
    NSInteger nextPage;
}

- (void)loadNotice:(enum IKNoticeType)type;

@property (readwrite) id<IKNoticeLoaderDelegate> delegate;

@end
