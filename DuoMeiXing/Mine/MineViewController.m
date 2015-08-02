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
#import "PhotographAlbumCategoryViewController.h"
#import "SettingsViewController.h"
#import "WebViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MineViewController
{
    UITableView *mainTableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupRightButton];
    
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
    return [[MineOptionModel resultOption] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[MineOptionModel resultOption] objectAtIndex:section] count];
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
        
        cell.cellImageView.image = [DisplayUtil getImageFromURL:[UserDataManager sharedUserDataManager].avatarUrl];
        
        cell.cellTitleLabel.text = [UserDataManager sharedUserDataManager].nickname;
        
        cell.cellPhoneLabel.text = [UserDataManager sharedUserDataManager].mobile;
        
//        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"limbo"]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }else{
        
        static NSString *cellIds = @"cellIds";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIds];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIds];
        }
        
        BaseOptionModel * option = [[[MineOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = option.title;
        
        cell.imageView.image = [[UIImage imageNamed:option.icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];

    BaseOptionModel * option = [[[MineOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSLog(@"%ld", option.ctrl);
    
    if (option.ctrl == kOptionCtrlTypeAccount) {
        
        AccountViewController *accountCtrl = [[AccountViewController alloc] init];
        
        [self.navigationController pushViewController:accountCtrl animated:YES];
        
    }else if(option.ctrl == kOptionCtrlTypePhotographAlbum){
        
        PhotographAlbumCategoryViewController *photographAlbumCategoryCtrl = [[PhotographAlbumCategoryViewController alloc] init];
        photographAlbumCategoryCtrl.category = kPhotographAlbumCategoryMyVideo;
        [self.navigationController pushViewController:photographAlbumCategoryCtrl animated:YES];
        
    }else if (option.ctrl == kOptionCtrlTypeSettings) {
        
        SettingsViewController *settingsCtrl = [[SettingsViewController alloc] init];
        
        [self.navigationController pushViewController:settingsCtrl animated:YES];
        
    }else if(option.ctrl == kOptionCtrlTypeOrder){
        
        [WebViewController showWebPageInViewCtrl:self withUrl:@"http://www.baidu.com" withPostData:nil withViewTitle:appName];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 15;
 
}

@end
