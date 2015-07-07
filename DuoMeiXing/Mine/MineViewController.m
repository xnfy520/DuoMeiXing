//
//  MineViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MineViewController.h"
#import "DNADef.h"
#import "MineTableViewCell.h"
#import "AccountViewController.h"
#import "PhotographAlbumViewController.h"
#import "SettingsViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MineViewController
{
    UITableView *mainTableView;
    NSArray *mainOptionData;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    mainOptionData = @[
                       @[
                           @{
                               @"title":@"帐户",
                               @"ctrl":@"Account"
                               }
                           ],
                       @[
                           @{
                               @"title":@"影集",
                               @"ctrl":@"PhotographAlbum"
                               }
                           ],
                       @[
                           @{
                               @"title":@"设置",
                               @"ctrl":@"Settings"
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 66;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        
        static NSString *cellId = @"cellId";
        
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        
        cell.avatarImageView.image = [UIImage imageNamed:@"limbo"];
        
        cell.avatarTitleLabel.text = @"天陨";
        
        cell.avatarPhoneLabel.text = @"15820448273";
        
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"limbo"]];
        
        return cell;
        
    }else{
        
        static NSString *cellIds = @"cellIds";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIds];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIds];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"limbo"];
        
        cell.textLabel.text = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *ctrl = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"ctrl"];
    
    if ([ctrl isEqualToString:@"Account"]) {
        
        AccountViewController *accountCtrl = [[AccountViewController alloc] init];
        
        [self.navigationController pushViewController:accountCtrl animated:YES];
        
    }else if([ctrl isEqualToString:@"PhotographAlbum"]){
        
        PhotographAlbumViewController *photographAlbumCtrl = [[PhotographAlbumViewController alloc] init];
        
        [self.navigationController pushViewController:photographAlbumCtrl animated:YES];
        
    }else if ([ctrl isEqualToString:@"Settings"]) {
        
        SettingsViewController *settingsCtrl = [[SettingsViewController alloc] init];
        
        [self.navigationController pushViewController:settingsCtrl animated:YES];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 0.001;
    }else{
        return 10;
    }
    
}

@end