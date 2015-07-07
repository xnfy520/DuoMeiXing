//
//  PopoverViewController.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/7.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PopoverViewController.h"
#import "DNADef.h"
#import "PopoverCell.h"

@interface PopoverViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PopoverViewController
{
    UITableView *mainTableView;
    NSArray *mainOptionData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = defaultNavigationBar;
    
    mainOptionData = @[
                       @{
                           @"title":@"发起群聊",
                           @"ctrl":@"1"
                           },
                       @{
                           @"title":@"添加朋友",
                           @"ctrl":@"2"
                           },
                       @{
                           @"title":@"扫一扫",
                           @"ctrl":@"3"
                           }
                       ];
    
    [self setupTableView];
}

- (void)setupTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 130, 120)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tableFooterView = [[UIView alloc] init];
    mainTableView.bounces = NO;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    mainTableView.separatorColor = [UIColor grayColor];
    [self.view addSubview:mainTableView];
    [self setupInsetsTableView:mainTableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 5)];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainOptionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    PopoverCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PopoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:55./255. green:63./255. blue:71./255. alpha:1.0];
    
    cell.imageView.image = [UIImage imageNamed:@"limbo"];
    
    cell.textLabel.text = [[mainOptionData objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    UIView *cellBg = [[UIView alloc] init];
    cellBg.backgroundColor = [UIColor colorWithRed:0.32 green:0.32 blue:0.32 alpha:1];
    cell.selectedBackgroundView = cellBg;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.delegate getPopoverClickType:[[mainOptionData objectAtIndex:indexPath.row] objectForKey:@"title"]];
}

@end
