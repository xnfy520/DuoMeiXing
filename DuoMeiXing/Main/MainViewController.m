//
//  MainViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MainViewController.h"
#import "DNADef.h"
#import "ListCell.h"
#import "DisplayViewController.h"


@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MainViewController

{
    UITableView *mainTableView;
    NSMutableArray *tableData;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightButton];
    [self setupMainTableView];
    
    tableData = [[NSMutableArray alloc] init];
    [self requstApi];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)requstApi
{
    RequstPage *requstPage = [[RequstPage alloc] init];
    requstPage.pageNo = @"1";
    requstPage.pageSize = @"10";

    RequestService *api = [[RequestService alloc] initReqeustUrl:apiMessage withPostData:requstPage withResponseValidator:[ResponseMessageData responseValidator]];

    [self showHUB];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [self hideHUB];
        
        NSLog(@"succeed");
        
        ResponseMessageData *messageData = [ResponseMessageData objectWithKeyValues:[request responseJSONObject]];
        
        [tableData setArray:messageData.result];
        
        [mainTableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        
        [self hideHUB];
        
        NSLog(@"failed");
        
        NSLog(@"%@", [[request responseJSONObject] objectForKey:@"code"]);
        
    }];

}

- (void)setupMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTableView];
    [self setupInsetsTableView:mainTableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return listCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ResponseMessageResultData * messageResultData = [tableData objectAtIndex:indexPath.row];
    
    cell.cellImageView.image = [DisplayUtil getImageFromURL:messageResultData.fromLogoUrl];

    NSString *badgeNum = [NSString stringWithFormat:@"%@", messageResultData.msgNumbers];
    
    cell.cellBadgeLabel.text = badgeNum;
    
    if ([badgeNum isEqualToString:@""] || badgeNum == nil || [badgeNum integerValue] == 0) {
        cell.cellBadgeLabel.hidden = YES;
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:([messageResultData.createTime doubleValue]/1000)];

    cell.cellDateLabel.text = [DisplayUtil getDateStringWithDate:date DateFormat:@"MM-dd"];

    cell.cellTitleLabel.text = messageResultData.fromNickName;
    
    cell.cellDetailLabel.text = messageResultData.content;
    
    cell.cellListType = kCellListMessage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DisplayViewController *displayCtrl = [[DisplayViewController alloc] init];
    displayCtrl.haveViedo = NO;
    [self.navigationController pushViewController:displayCtrl animated:YES];
    
}

@end
