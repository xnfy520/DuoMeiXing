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
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"设置";
    
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
    return [[SettingOptionModel resultOption] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[SettingOptionModel resultOption] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        
    static NSString *cellIds = @"cellIds";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIds];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIds];
    }
    
    BaseOptionModel * option = [[[SettingOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = option.title;

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    if (option.ctrl == kOptionCtrlTypeExit) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseOptionModel * option = [[[SettingOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
  
    if (option.ctrl == kOptionCtrlTypeExit) {
        [self exitAction];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
    
}

- (void)exitAction
{
    UIAlertView *exitAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出当前帐号?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [exitAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1 ) //确定按钮被点解
    {
        postEvent(globalLogoutAction);
    }
}


@end
