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
#import "DNATabBarController.h"
#import "RegisterViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "AFNetworking.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MainViewController

{
    UITableView *mainTableView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightButton];
    [self setupMainTableView];
    
//    [[AFAppDotNetAPIClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
//        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
//        NSLog(@"%@", postsFromResponse);
//    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
//        
//    }];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    NSDictionary *parameters = @{@"foo": @"bar"};
//    [manager POST:@"http://113.105.85.230:66/getBanner.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.cellImageView.image = [UIImage imageNamed:@"limbo"];
    
    cell.cellBadgeLabel.text = @"2";
    
    cell.cellDateLabel.text = @"6月16日";
    
    cell.cellTitleLabel.text = @"天陨";
    
    cell.cellDetailLabel.text = @"雪念飞叶";
    
    cell.showBadge = YES;
    
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
