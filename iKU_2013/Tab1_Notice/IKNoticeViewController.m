//
//  IKNoticeViewController.m
//  iKU_2013
//
//  Created by 기용 이 on 13. 7. 21..
//  Copyright (c) 2013년 기용 이. All rights reserved.
//

#import "IKNoticeViewController.h"

@interface IKNoticeViewController ()

@end

@implementation IKNoticeViewController

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
    
    [self initNoticeList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 초기화

- (void)initNoticeList
{
    [noticeButton1 setSelected:YES];
    
    [ETUtility showActivityIndicatorView:[self view]];
    
    IKNoticeLoader *noticeLoader = [IKNoticeLoader new];
    [noticeLoader setDelegate:self];
    [noticeLoader loadNotice:IKNoticeType1_E];
}


#pragma mark - 탭 선택

- (IBAction)selectTab:(id)sender
{
    [self enableAll:NO];
    
    [self disSelectAll];
    [sender setSelected:YES];
    
    [ETUtility showActivityIndicatorView:[self view]];
    
    IKNoticeLoader *noticeLoader = [IKNoticeLoader new];
    [noticeLoader setDelegate:self];
    [noticeLoader loadNotice:[sender tag]];
}

- (void)enableAll:(BOOL)enable
{
    [noticeListTableView setAllowsSelection:enable];
    
    [noticeButton1 setUserInteractionEnabled:enable];
    [noticeButton2 setUserInteractionEnabled:enable];
    [noticeButton3 setUserInteractionEnabled:enable];
    [noticeButton4 setUserInteractionEnabled:enable];
}

- (void)disSelectAll
{
    [noticeButton1 setSelected:NO];
    [noticeButton2 setSelected:NO];
    [noticeButton3 setSelected:NO];
    [noticeButton4 setSelected:NO];
}


#pragma mark - 델리게이트 메서드

#pragma mark * IKNoticeLoaderDelegate

- (void)noticeListLoaded:(NSMutableArray *)noticeList
{
    [ETUtility hideActivityIndicatorView];
    
    noticeListArray = noticeList;
//    NSLog(@"%@", noticeListArray);
    
    [noticeListTableView reloadData];
    [self enableAll:YES];
}

#pragma mark UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [noticeListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IKNoticeCell";
    IKNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[IKNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tempNoticeDic = [noticeListArray objectAtIndex:indexPath.row];
    
    [[cell noticeIndexLabel] setText:[tempNoticeDic objectForKey:@"index"]];
    [[cell noticeTitleLabel] setText:[tempNoticeDic objectForKey:@"title"]];
    [[cell noticeDateLabel] setText:[tempNoticeDic objectForKey:@"date"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
