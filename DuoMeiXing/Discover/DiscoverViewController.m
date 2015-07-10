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
#import "WebViewController.h"
#import "ContactsViewController.h"

@interface DiscoverViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mainTableView;
    NSArray *mainOptionData;
}
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;

    [self.view addSubview:mainTableView];
    
    [self setupInsetsTableView:mainTableView];
    
    mainOptionData = @[
                       @[
                           @{
                               @"title":@"最新",
                               @"icon":@"home_disc_last",
                               @"ctrl":@"newest"
                               },
                           @{
                               @"title":@"最热",
                               @"icon":@"home_disc_hot",
                               @"ctrl":@"hot"
                               }
                           ],
                       @[
                           @{
                               @"title":@"大师",
                               @"icon":@"home_disc_mentor",
                               @"ctrl":@"contacts"
                               },
                           @{
                               @"title":@"专业老师",
                               @"icon":@"home_disc_teacher",
                               @"ctrl":@"contacts"
                               
                               }
                           ],
                       @[
                           @{
                               @"title":@"乐器",
                               @"icon":@"home_disc_teaching_tgita",
                               @"ctrl":@"master"
                               },
                           @{
                               @"title":@"琴行",
                               @"icon":@"home_disc_teaching_piano",
                               @"ctrl":@"specialty"
                               }
                           ]
                       ];
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
    return mainOptionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[mainOptionData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    NSString *title = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *icon = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"icon"];
    
    cell.textLabel.text = title;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.imageView.image = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *ctrl = [[[mainOptionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"ctrl"];
    
    PhotographAlbumViewController *photographAlbumCtrl = [[PhotographAlbumViewController alloc] init];
    
    ContactsViewController *contactsCtrl = [[ContactsViewController alloc] init];
    
    if([ctrl isEqualToString:@"newest"]){
        
        photographAlbumCtrl.listType = kPhotographAlbumTypeNewest;
        
        [self.navigationController pushViewController:photographAlbumCtrl animated:YES];
        
    }else if ([ctrl isEqualToString:@"hot"]) {
        
        photographAlbumCtrl.listType = kPhotographAlbumTypeHot;
        
        [self.navigationController pushViewController:photographAlbumCtrl animated:YES];
        
    }else if([ctrl isEqualToString:@"master"]){
        
        [WebViewController showWebPageInViewCtrl:self withUrl:@"http://www.163.com" withPostData:nil withViewTitle:appName];
    
    }else if([ctrl isEqualToString:@"specialty"]){
    
        [WebViewController showWebPageInViewCtrl:self withUrl:@"http://www.qq.com" withPostData:nil withViewTitle:appName];
        
    }else if([ctrl isEqualToString:@"contacts"]){

        contactsCtrl.title = title;
        contactsCtrl.notHeader = YES;
        [self.navigationController pushViewController:contactsCtrl animated:YES];
        
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
