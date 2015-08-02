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

@interface PhotographAlbumCategoryViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mainTableView;
    NSArray *mainTableHeaderData;
    NSMutableArray *mainTableData;
}
@end

@implementation PhotographAlbumCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightButton];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTableView];
    
    [self setupInsetsTableView:mainTableView];

    if(self.category == kPhotographAlbumCategoryHot){
        mainTableData = [NSMutableArray arrayWithCapacity:2];
        [self sendHotBatchRequest];
    }else if (self.category == kPhotographAlbumCategoryTeaching) {
        mainTableData = [NSMutableArray arrayWithCapacity:4];
        [self sendTeachingBatchRequest];
    }else if(self.category == kPhotographAlbumCategoryMyVideo){
        mainTableData = [NSMutableArray arrayWithCapacity:3];
        [self sendMyVideoBatchRequest];
    }
}

- (void)sendHotBatchRequest
{
    RequestService *api1 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTopPlay] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api2 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTopComment] withResponseValidator:[ResponseVideo responseValidator]];
    
    [self sendBatchRequestWith:@[api1, api2]];
}

- (void)sendTeachingBatchRequest
{
    RequestService *api1 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingTguita] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api2 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingPiano] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api3 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingEguita] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api4 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstTeachingViolin] withResponseValidator:[ResponseVideo responseValidator]];
    
    [self sendBatchRequestWith:@[api1, api2, api3, api4]];
}

- (void)sendMyVideoBatchRequest
{
    RequestService *api1 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstMePublished] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api2 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstMeChecking] withResponseValidator:[ResponseVideo responseValidator]];
    RequestService *api3 = [[RequestService alloc] initReqeustUrl:appAPIVideo withPostData:[RequstVideo requstMeUploading] withResponseValidator:[ResponseVideo responseValidator]];

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
        for (int i = 0; i<requests.count; i++) {
            RequestService *result = (RequestService *)requests[i];
            ResponseVideo *responseData = [ResponseVideo objectWithKeyValues:[result responseJSONObject]];
            [mainTableData addObject:responseData.result];
        }
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
    return mainTableHeaderData.count;
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
    
    PhotographAlbumViewController *photographAlbumCtrl = [[PhotographAlbumViewController alloc] init];

    [self.navigationController pushViewController:photographAlbumCtrl animated:YES];
}

@end
