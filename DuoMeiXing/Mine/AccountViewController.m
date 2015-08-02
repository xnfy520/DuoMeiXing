//
//  AccountViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "AccountViewController.h"

#import "DNADef.h"

#import "FieldsEditViewController.h"

#define AVATAR_VIEW_TAG 1

@interface AccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation AccountViewController
{
    UITableView *mainTableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
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
    return [[AccountOptionModel resultOption] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AccountOptionModel resultOption] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *avatarImageView;
    
    static NSString *cellIds = @"cellIds";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIds];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIds];
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-35-30, (CGRectGetHeight(cell.contentView.frame)-30)/2, 30, 30)];
        avatarImageView.tag = AVATAR_VIEW_TAG;
        avatarImageView.hidden = YES;
        [cell.contentView addSubview:avatarImageView];
    }else{
        avatarImageView = (UIImageView *)[cell.contentView viewWithTag:AVATAR_VIEW_TAG];
    }
    
    BaseOptionModel * option = [[[AccountOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = option.title;
    
    if (option.ctrl == kOptionCtrlTypeNickname) {
        
        cell.detailTextLabel.text = [UserDataManager sharedUserDataManager].nickname;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        
    }else if(option.ctrl == kOptionCtrlTypeAvatar){
        
        avatarImageView.hidden = NO;
        [avatarImageView sd_setImageWithURL:[UserDataManager sharedUserDataManager].avatarUrl];
        
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseOptionModel * option = [[[AccountOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (option.ctrl == kOptionCtrlTypeNickname) {
        FieldsEditViewController *fieldsEditCtrl = [[FieldsEditViewController alloc] init];
        [self.navigationController presentViewController:[DNATabBarController setCtrl:fieldsEditCtrl] animated:YES completion:^{
            
        }];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
    
}

@end
