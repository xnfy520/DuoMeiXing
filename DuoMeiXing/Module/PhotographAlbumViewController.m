//
//  PhotographAlbumViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PhotographAlbumViewController.h"

#import "DisplayViewController.h"
#import "DNADef.h"
#import "ListCell.h"

@interface PhotographAlbumViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation PhotographAlbumViewController
{
    UITableView *mainTableView;
    NSMutableArray *tableData;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = [DisplayUtil stringWithOptionCtrlType:self.listType];

    [self setupMainTableView];
    
    tableData = [[NSMutableArray alloc] init];

    switch (self.listType) {
        case kOptionCtrlTypeNewest:
            [self sendNewestRequest];
            break;
        case kOptionCtrlTypeTopPaly:
            [self sendTopPalyRequest];
            break;
        case kOptionCtrlTypeTopComment:
            [self sendTopCommentRequest];
            break;
        case kOptionCtrlTypeTeachingTgita:
            [self sendTeachingTgitaRequest];
            break;
        case kOptionCtrlTypeTeachingPiano:
            [self sendTeachingPianoRequest];
            break;
        case kOptionCtrlTypeTeachingEgita:
            [self sendTeachingEgitaRequest];
            break;
        case kOptionCtrlTypeTeachingViolin:
            [self sendTeachingViolinRequest];
            break;
        case kOptionCtrlTypeMyPublished:
            [self sendMyPublishedRequest];
            break;
        case kOptionCtrlTypeMyChecking:
            [self sendMyCheckingRequest];
            break;
        case kOptionCtrlTypeMyUploading:
            [self sendMyUploadingRequest];
            break;
        default:
            break;
    }
}

- (void)sendNewestRequest
{
    RequestService *api = [RequestService videoLastReqeustPostData:[RequstVideo requstNewestWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendTopPalyRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstTopPlayWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendTopCommentRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstTopCommentWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendTeachingTgitaRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstTeachingTguitaWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendTeachingPianoRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstTeachingPianoWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendTeachingEgitaRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstTeachingEguitaWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendTeachingViolinRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstTeachingViolinWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendMyPublishedRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstMePublishedWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendMyCheckingRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstMeCheckingWithPageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)sendMyUploadingRequest
{
    RequestService *api = [RequestService videoReqeustPostData:[RequstVideo requstMeUploadingWithPageNo:1 withPageSize:20]];
    [self sendRequestWith:api];
}

- (void)sendRequestWith:(RequestService *)api
{
    
    [self showHUB];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [self hideHUB];
        
        NSLog(@"succeed");
        
        ResponseVideo *responseData = [ResponseVideo objectWithKeyValues:[request responseJSONObject]];
        
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
    
    mainTableView.emptyDataSetDelegate = self;
    mainTableView.emptyDataSetSource = self;
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
    
    ResponseVideoResult * result = [tableData objectAtIndex:indexPath.row];
    
    cell.cellListType = kCellListVideo;
    
    [cell.cellImageView sd_setImageWithURL:result.picUrl];
    
     NSDate * date = [NSDate dateWithTimeIntervalSince1970:([result.createTime doubleValue]/1000)];
    
    cell.cellDateLabel.text = [DisplayUtil getDateStringWithDate:date DateFormat:@"MM-dd"];;
    
    cell.cellTitleLabel.text = result.name;
    
    cell.cellDetailLabel.text = result.desc;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    DisplayViewController *displayCtrl = [[DisplayViewController alloc] init];
    displayCtrl.haveViedo = YES;
    [self.navigationController pushViewController:displayCtrl animated:YES];
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"placeholder_instagram"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有数据";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
