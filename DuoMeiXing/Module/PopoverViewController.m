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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = defaultNavigationBar;
    
    [self setupTableView];
}

- (void)setupTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
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
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
        
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
    return [[PopoverOptionModel resultOption] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    PopoverCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PopoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    BaseOptionModel * option = [[PopoverOptionModel resultOption] objectAtIndex:indexPath.row];
    
    NSString *title = option.title;
    
    NSString *icon = option.icon;
    
    cell.backgroundColor = [UIColor colorWithRed:55./255. green:63./255. blue:71./255. alpha:1.0];
    
    cell.imageView.image = [UIImage imageNamed:icon];
    
    cell.textLabel.text = title;
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
    BaseOptionModel * option = [[PopoverOptionModel resultOption] objectAtIndex:indexPath.row];
    [self.delegate getPopoverClickType:option.ctrl];
}

@end
