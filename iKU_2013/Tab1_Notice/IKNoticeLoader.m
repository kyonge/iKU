//
//  IKNoticeLoader.m
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 23..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import "IKNoticeLoader.h"

@implementation IKNoticeLoader

@synthesize delegate;

+ (NSArray *)noticeURLArray
{
    return [NSArray arrayWithObjects:@"", @"E", @"NG", @"R", @"J", nil];
}

- (void)loadNotice:(enum IKNoticeType)type
{
    boardListArray = [NSMutableArray array];
    noticeType = type;
    nextPage = 1;
    
    [NSThread detachNewThreadSelector:@selector(crawlData) toTarget:self withObject:nil];
}

- (void)crawlData
{
    while ([self parseBoardList:[self loadNotice:noticeType WithPage:++nextPage]]) {
//        NSLog(@"donePage : %d", nextPage);
    }
    
    [delegate noticeListLoaded:boardListArray];
}

- (NSString *)loadNotice:(enum IKNoticeType)type WithPage:(NSInteger)page
{
    NSString *noticeURLString = [NSString stringWithFormat:@"http://www.korea.ac.kr/do/Main/NoticeList.do?type=%@&p_rel=1&p=%d&p_rel=1", [[IKNoticeLoader noticeURLArray] objectAtIndex:type], page - 2];
    NSData *noticeData = [NSData dataWithContentsOfURL:[NSURL URLWithString:noticeURLString]];
    
    return [[NSString alloc] initWithData:noticeData encoding:NSUTF8StringEncoding];
}

- (BOOL)parseBoardList:(NSString *)dataString
{
//    NSLog(@"dataString : %@", dataString);
    
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:dataString error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return NO;
    }
    
    HTMLNode *bodyNode = [parser body];
    
    //테이블 내용
    HTMLNode *tableNode = [bodyNode findChildTag:@"table"];
    HTMLNode *tableBodyNode = [tableNode findChildTag:@"tbody"];
    NSArray *boardRawListArray = [tableBodyNode findChildTags:@"tr"];
    
    for (HTMLNode *inputNode in boardRawListArray) {
        NSArray *inputNodes = [inputNode findChildTags:@"td"];
        NSString *boardIndex = [[inputNodes objectAtIndex:0] allContents];
        NSMutableString *tempBoardTitle = [NSMutableString stringWithString:[[inputNodes objectAtIndex:1] allContents]];
        [tempBoardTitle replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempBoardTitle length])];
        [tempBoardTitle replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [tempBoardTitle length])];
        NSString *boardTitle = [tempBoardTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *boardLink = [[[inputNodes objectAtIndex:1] findChildTag:@"a"] getAttributeNamed:@"href"];
        NSString *boardDate = [[inputNodes objectAtIndex:3] allContents];
        
        NSArray *tempBoardObjectArray = [NSArray arrayWithObjects:boardIndex, boardTitle, boardLink, boardDate, nil];
        NSArray *tempBoardKeyArray = [NSArray arrayWithObjects:@"index", @"title", @"link", @"date", nil];
        NSDictionary *tempBoardDataDic = [NSDictionary dictionaryWithObjects:tempBoardObjectArray forKeys:tempBoardKeyArray];
        
//        NSLog(@"%@ : %@\t/ %@", boardIndex, boardTitle, boardDate);
        
        [boardListArray addObject:tempBoardDataDic];
    }
    
    //페이징
    HTMLNode *pagingNode = [tableNode nextSibling];
    NSString *pagingString = [pagingNode allContents];
    NSArray *pagingArray = [pagingString componentsSeparatedByString:@"\n"];
    for (NSString *tempString in pagingArray) {
        NSString *tempPage = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        if ([tempPage length]) NSLog(@"%@, %d", tempPage, nextPage);
        if ([tempPage isEqualToString:[NSString stringWithFormat:@"%d", nextPage]])
            return YES;
    }
    
    return NO;
}

@end
