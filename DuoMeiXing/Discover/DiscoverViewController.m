//
//  DiscoverViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DNADef.h"
#import "PhotographAlbumViewController.h"
#import "PhotographAlbumCategoryViewController.h"
#import "WebViewController.h"
#import "ContactsViewController.h"

@interface DiscoverViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mainTableView;
}
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightButton];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;

    [self.view addSubview:mainTableView];
    
    [self setupInsetsTableView:mainTableView];
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [DiscoverOptionModel resultOption].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DiscoverOptionModel resultOption] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    BaseOptionModel * option = [[[DiscoverOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    cell.textLabel.text = option.title;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.imageView.image = [[UIImage imageNamed:option.icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseOptionModel * option = [[[DiscoverOptionModel resultOption] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    PhotographAlbumViewController *photographAlbumCtrl = [[PhotographAlbumViewController alloc] init];
    
    if(option.ctrl == kOptionCtrlTypeNewest){
        
        photographAlbumCtrl.listType = kOptionCtrlTypeNewest;
        
        [self.navigationController pushViewController:photographAlbumCtrl animated:YES];
        
    }else if (option.ctrl == kOptionCtrlTypeHot) {
        
        PhotographAlbumCategoryViewController *photographAlbumCategoryCtrl = [[PhotographAlbumCategoryViewController alloc] init];
        photographAlbumCategoryCtrl.category = kPhotographAlbumCategoryHot;
        [self.navigationController pushViewController:photographAlbumCategoryCtrl animated:YES];
        
    }else if(option.ctrl == kOptionCtrlTypeContacts){
        
        ContactsViewController *contactsCtrl = [[ContactsViewController alloc] init];
        contactsCtrl.title = option.title;
        contactsCtrl.notHeader = YES;
        contactsCtrl.notPopover = YES;
        contactsCtrl.hasInvitation = NO;
        [self.navigationController pushViewController:contactsCtrl animated:YES];
        
    }else if(option.ctrl == kOptionCtrlTypeInstrument){
        
        [WebViewController showWebPageInViewCtrl:self withUrl:@"http://www.hao123.com" withPostData:nil withViewTitle:appName];
        
    }else if(option.ctrl == kOptionCtrlTypeTeaching){
        
        PhotographAlbumCategoryViewController *photographAlbumCategoryCtrl = [[PhotographAlbumCategoryViewController alloc] init];
        photographAlbumCategoryCtrl.category = kPhotographAlbumCategoryTeaching;
        [self.navigationController pushViewController:photographAlbumCategoryCtrl animated:YES];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 15;
    }else{
        return 0.001;
    }
    
}
@end
