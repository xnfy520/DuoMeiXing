//
//  ContactsViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ContactsViewController.h"
#import "DNADef.h"

@interface ContactsViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@end

@implementation ContactsViewController

{
    UITableView *mainTableView;
    UISearchBar *searchBar;
    UISearchController *searchCtrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainTableView];

}

- (void)setupMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTableView];
    [self setupInsetsTableView:mainTableView];
    
    [self setupSearchController];
}

- (void)setupSearchController
{
    searchCtrl = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchCtrl.hidesNavigationBarDuringPresentation = NO;
    searchCtrl.searchResultsUpdater = self; //设置显示搜索结果的控制器
    searchCtrl.dimsBackgroundDuringPresentation = YES; //设置开始搜索时背景显示与否
    [searchCtrl.searchBar sizeToFit]; //设置searchBar位置自适应
    searchCtrl.searchBar.placeholder = @"搜索";
    searchCtrl.searchBar.showsBookmarkButton = NO;
    searchCtrl.searchBar.showsScopeBar = NO;
    searchCtrl.searchBar.showsSearchResultsButton = NO;
    searchCtrl.searchBar.showsCancelButton = NO;
    mainTableView.tableHeaderView = searchCtrl.searchBar;
    
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *filterString = searchController.searchBar.text;
    NSLog(@"%@", filterString);
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"limbo"];
    
    cell.textLabel.text = @"天陨";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
