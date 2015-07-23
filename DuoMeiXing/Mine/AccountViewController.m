//
//  AccountViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "AccountViewController.h"

#import "DNADef.h"

#import "DNATabBarController.h"

#import "FieldsEditViewController.h"

@interface AccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation AccountViewController
{
    UITableView *mainTableView;
    NSArray *mainOptionData;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
    mainOptionData = @[
                       @[
                           @{
                               @"title":@"头像",
                               @"ctrl":@"avatar"
                               }
                           ],
                       @[
                           @{
                               @"title":@"昵称",
                               @"ctrl":@"nickname"
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIds];
    }
    
    cell.textLabel.text = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *ctrl = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"ctrl"];
    
    if ([ctrl isEqualToString:@"nickname"]) {
        
        cell.detailTextLabel.text = @"天陨";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        
    }else if([ctrl isEqualToString:@"avatar"]){
        UIImageView * avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-35-30, (CGRectGetHeight(cell.contentView.frame)-30)/2, 30, 30)];
        avatarImageView.image = [UIImage imageNamed:@"avatar"];
//        cell.accessoryView = avatarImageView;
        [cell.contentView addSubview:avatarImageView];
        
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *ctrl = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"ctrl"];
    
    if ([ctrl isEqualToString:@"nickname"]) {
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
