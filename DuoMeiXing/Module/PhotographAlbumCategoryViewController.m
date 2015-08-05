//
//  PhotographAlbumCategoryViewController.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/29.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PhotographAlbumCategoryViewController.h"
#import "PhotographAlbumViewController.h"
#import "ListCell.h"
#import "DisplayViewController.h"
#import "YTKBatchRequest.h"

@interface PhotographAlbumCategoryViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>
{
    UITableView *mainTableView;
    NSArray *mainTableHeaderData;
    NSMutableArray *mainTableData;
    BOOL isEmpty;
}
@end

@implementation PhotographAlbumCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightButton];
    
    [self setupMainTableView];

    if(self.category == kPhotographAlbumCategoryHot){
        
        self.title = [DisplayUtil stringWithPhotographAlbumCategory:kPhotographAlbumCategoryHot];
        mainTableData = [NSMutableArray arrayWithCapacity:2];
        [self sendHotBatchRequest];
    }else if (self.category == kPhotographAlbumCategoryTeaching) {
        self.title = [DisplayUtil stringWithPhotographAlbumCategory:kPhotographAlbumCategoryTeaching];
        mainTableData = [NSMutableArray arrayWithCapacity:4];
        [self sendTeachingBatchRequest];
    }else if(self.category == kPhotographAlbumCategoryMyVideo){
        self.title = [DisplayUtil stringWithPhotographAlbumCategory:kPhotographAlbumCategoryMyVideo];
        mainTableData = [NSMutableArray arrayWithCapacity:3];
        [self sendMyVideoBatchRequest];
    }
}

- (void)setupMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTableView];
    
    [self setupInsetsTableView:mainTableView];
    
    mainTableView.emptyDataSetDelegate = self;
    mainTableView.emptyDataSetSource = self;
}

- (void)sendHotBatchRequest
{
    RequestService *api1 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTopPlayWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api2 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTopCommentWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    
    [self sendBatchRequestWith:@[api1, api2]];
}

- (void)sendTeachingBatchRequest
{
    RequestService *api1 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingTguitaWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api2 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingPianoWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api3 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingEguitaWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api4 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingViolinWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    
    [self sendBatchRequestWith:@[api1, api2, api3, api4]];
}

- (void)sendMyVideoBatchRequest
{
    RequestService *api1 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstMePublishedWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api2 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstMeCheckingWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api3 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstMeUploadingWithPageNo:1 withPageSize:5] withResponseValidator:[ResponseVideo responseValidator]];

    [self sendBatchRequestWith:@[api1, api2, api3]];
}

- (void)sendBatchRequestWith:(NSArray *)apis
{
    [self showHUB];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apis];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        
        if(self.category == kPhotographAlbumCategoryHot){
            mainTableHeaderData = [PACHotOptionModel resultOption];
        }else if (self.category == kPhotographAlbumCategoryTeaching) {
            mainTableHeaderData = [PACTeachingOptionModel resultOption];
        }else if(self.category == kPhotographAlbumCategoryMyVideo){
            mainTableHeaderData = [PACMyVideoOptionModel resultOption];
        }
        
        [self hideHUB];
        NSLog(@"succeed");
        NSArray *requests = batchRequest.requestArray;
        int emptyCount = 0;
        for (int i = 0; i<requests.count; i++) {
            RequestService *result = (RequestService *)requests[i];
            ResponseVideo *responseData = [ResponseVideo objectWithKeyValues:[result responseJSONObject]];
            
            if (responseData.result.count<=0) {
                emptyCount++;
            }
            
            [mainTableData addObject:responseData.result];
        }
        if (emptyCount == requests.count) {
            isEmpty = YES;
        }
        
        NSLog(@"%@", mainTableData);
        [mainTableView reloadData];
    } failure:^(YTKBatchRequest *batchRequest) {
        NSLog(@"failed");
    }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    if (mainTableHeaderData.count > 0) {
        BaseOptionModel * option = [mainTableHeaderData objectAtIndex:section];
        UIImageView *headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (35-25)/2, 25, 25)];
        NSString *icon = option.icon;
        headerIcon.image = [UIImage imageNamed:icon];
        [headerView addSubview:headerIcon];
        
        UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerIcon.frame)+5, (35-15)/2, screenWidth-40*2, 15)];
        headerTitle.font = [UIFont boldSystemFontOfSize:14];
        headerTitle.text = option.title;
        [headerView addSubview:headerTitle];
        
        UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [headerButton setImage:[[[UIImage imageNamed:@"iosArrowRight"] imageToSize:CGSizeMake(8, 21)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        headerButton.contentMode = UIViewContentModeCenter;
        
        [headerButton addTarget:self action:@selector(toCategory:) forControlEvents:UIControlEventTouchUpInside];
        headerButton.frame  = CGRectMake(screenWidth-25-5, (35-25)/2, 25, 25);
        headerButton.tag = option.ctrl;
        [headerView addSubview:headerButton];
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return listCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return isEmpty ? 0 : mainTableHeaderData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainTableData.count > 0 ? [[mainTableData objectAtIndex:section] count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    if (mainTableData.count>0) {
        
        ResponseVideoResult * result = [[mainTableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        cell.cellListType = kCellListVideo;
        
        [cell.cellImageView sd_setImageWithURL:result.picUrl];
        
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:([result.createTime doubleValue]/1000)];
        
        cell.cellDateLabel.text = [DisplayUtil getDateStringWithDate:date DateFormat:@"MM-dd"];;
        
        cell.cellTitleLabel.text = result.name;
        
        cell.cellDetailLabel.text = result.desc;
    }
    

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];

    DisplayViewController *displayCtrl = [[DisplayViewController alloc] init];
    displayCtrl.haveViedo = YES;
    [self.navigationController pushViewController:displayCtrl animated:YES];

}

- (void)toCategory:(id)sender
{
    UIButton *headerButton = (UIButton *)sender;
    PhotographAlbumViewController *photographAlbumCtrl = [[PhotographAlbumViewController alloc] init];
    photographAlbumCtrl.listType = headerButton.tag;
    [self.navigationController pushViewController:photographAlbumCtrl animated:YES];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
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
