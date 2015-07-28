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
#import "MessageApi.h"

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

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requstApi];
}

- (void)requstApi
{
    MessageApi *api = [[MessageApi alloc] initWithPageNo:@"1" pageSize:@"10"];
    
    if ([api cacheJson]) {
        
        NSLog(@"cacheJson");
        
        NSDictionary *cacheData = [api cacheJson];
        
        NSArray * cacheResult = [cacheData objectForKey:@"result"];
        
        [tableData setArray:cacheResult];
        
        [mainTableView reloadData];
    }
    
    [self showHUB];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self hideHUB];
        NSLog(@"succeed");
        
        NSDictionary * respData = [request responseJSONObject];
        
        NSArray * respResult = [respData objectForKey:@"result"];
        
        [tableData setArray:respResult];
        
        [mainTableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
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
    
    cell.cellImageView.image = [DisplayUtil getImageFromURL:[[tableData objectAtIndex:indexPath.row] objectForKey:@"fromLogoUrl"]];
    
    cell.cellBadgeLabel.text = [NSString stringWithFormat:@"%@", [[tableData objectAtIndex:indexPath.row] objectForKey:@"msgNumbers"]];

    NSDate * date = [NSDate dateWithTimeIntervalSince1970:([[[tableData objectAtIndex:indexPath.row] objectForKey:@"createTime"] doubleValue]/1000)];
    
    cell.cellDateLabel.text = [DisplayUtil getDateStringWithDate:date DateFormat:@"MM-dd"];
    
    cell.cellTitleLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"fromNickName"];
    
    cell.cellDetailLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"content"];
    
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
