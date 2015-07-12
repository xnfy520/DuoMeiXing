//
//  MineViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MineViewController.h"
#import "DNADef.h"
#import "AccountAvatarCell.h"
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
    
    [self setupRightButton];
    
    mainOptionData = @[
                       @[
                           @{
                               @"title":@"帐户",
                               @"ctrl":@"Account",
                               @"icon":@""
                               }
                           ],
                       @[
                           @{
                               @"title":@"影集",
                               @"ctrl":@"PhotographAlbum",
                               @"icon":@"home_me_video"
                               }
                           ],
                       @[
                           @{
                               @"title":@"设置",
                               @"ctrl":@"Settings",
                               @"icon":@"home_me_settings"
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
        
        AccountAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[AccountAvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        
        cell.avatarImageView.image = [UIImage imageNamed:@"avatar"];
        
        cell.avatarTitleLabel.text = @"天陨";
        
        cell.avatarPhoneLabel.text = @"15820448273";
        
//        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"limbo"]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }else{
        
        static NSString *cellIds = @"cellIds";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIds];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIds];
        }
        
        NSString *title = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
        
        NSString *icon = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"icon"];
        
        cell.imageView.image = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        cell.textLabel.text = title;
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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
        return 15;
    }
    
}

@end
