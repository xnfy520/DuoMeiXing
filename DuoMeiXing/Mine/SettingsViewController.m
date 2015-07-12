//
//  SettingsViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "SettingsViewController.h"
#import "DNADef.h"

@interface SettingsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingsViewController
{
    UITableView *mainTableView;
    NSArray *mainOptionData;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"设置";
    
    mainOptionData = @[
                       @[
                           @{
                               @"title":@"关于哆每星",
                               @"ctrl":@"about"
                               },
                           @{
                               @"title":@"检查更新",
                               @"ctrl":@"update"
                               }
                           ],
                       @[
                           @{
                               @"title":@"退出登录",
                               @"ctrl":@"exit"
                               }
                           ]
                       ];
    
    [self setupMainTableView];
    
}

- (void)setupMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    [mainTableView setSectionFooterHeight:0];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mainOptionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[mainOptionData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        
    static NSString *cellIds = @"cellIds";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIds];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIds];
    }
    
    cell.textLabel.text = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *ctrl = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"ctrl"];
    
    if ([ctrl isEqualToString:@"exit"]) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
    
}


@end
