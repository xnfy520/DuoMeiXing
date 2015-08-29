//
//  MessageViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/8/29.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MessageViewController.h"
#import "DNADef.h"
#import "ListCell.h"
#import "PhotographAlbumViewController.h"
#import "DisplayViewController.h"

@implementation MessageViewController
{
    UITableView *mainTableView;
    NSMutableArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRightButton];
    [self setupMainTableView];
    tableData = [[NSMutableArray alloc] init];
    
    if (_listTitle) {
        self.title = _listTitle;
    }else{
        self.title = appName;
    }
    
    if (_listType == kOptionCtrlTypeMessageComment) {
        [self sendMessageCommentRequest];
    }else if(_listType == kOptionCtrlTypeMessageUpload){
        [self sendMessageUploadRequest];
    }else{
        [self sendMessageSummary];
    }
    NSLog(@"%@----", [UserDataManager sharedUserDataManager].sessionId);
}

- (void)sendMessageSummary
{
    RequestService *api = [RequestService messageSummaryReqeust];
    [self sendRequestWith:api];
}

- (void)sendMessageCommentRequest
{
    RequestService *api = [RequestService messageAllReqeustPostData:[RequstMessageAll requstMessageCommentWithVideoId:_userinfo PageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)sendMessageUploadRequest
{
    RequestService *api = [RequestService messageAllReqeustPostData:[RequstMessageAll requstMessageUploadWithFirendId:_userinfo PageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)sendRequestWith:(RequestService *)api
{
    
    [self showHUB];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [self hideHUB];
        
        NSLog(@"succeed");

        ResponseMessageResult *responseData = [ResponseMessageResult objectWithKeyValues:[request responseJSONObject]];
        
        [tableData setArray:responseData.result];
        

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
    
    cell.cellListType = kCellListMessage;
    
    if (tableData.count>0) {
        cell.cellData = [tableData objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ResponseMessage *result = [tableData objectAtIndex:indexPath.row];
    
    if (_isDisplay){
    
        DisplayViewController *displayCtrl = [[DisplayViewController alloc] init];
        
        displayCtrl.videoId = result.videoId;
        if ([result.chatType isEqualToString:@"VIDEOFILE"]) {
            displayCtrl.pannelIndex = kDisplayPannelInformation;
        }else{
            displayCtrl.pannelIndex = kDisplayPannelReview;
        }
        
        [self.navigationController pushViewController:displayCtrl animated:YES];
        
    }else{
        
        MessageViewController *messageCtrl = [[MessageViewController alloc] init];
        messageCtrl.listTitle = result.fromNickName;
        if ([result.chatType isEqualToString:@"VIDEOFILE"]) {
            messageCtrl.listType = kOptionCtrlTypeMessageUpload;
            messageCtrl.userinfo = result.fromId;
        }else{
            messageCtrl.listType = kOptionCtrlTypeMessageComment;
            messageCtrl.userinfo = result.videoId;
        }
        messageCtrl.isDisplay = YES;
        [self.navigationController pushViewController:messageCtrl animated:YES];
        
    }
    

    
}


@end
