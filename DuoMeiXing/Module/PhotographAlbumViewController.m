//
//  PhotographAlbumViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/6.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PhotographAlbumViewController.h"
#import "DNADef.h"
#import "ListCell.h"

@interface PhotographAlbumViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PhotographAlbumViewController
{
    UITableView *mainTableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    switch (self.listType) {
            
        case kPhotographAlbumTypeDefault:
            self.title = @"我的视频";
            break;
        case kPhotographAlbumTypeNewest:
            self.title = @"最新视频";
            break;
        case kPhotographAlbumTypeHot:
            self.title = @"最热视频";
            break;
        default:
            self.title = @"我的视频";
            break;
    }
    
    [self setupMainTableView];
    
}

- (void)setupMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tableFooterView = [[UIView alloc] init];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return listCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    cell.imageWidth = 50;
    
    cell.avatarImageView.image = [UIImage imageNamed:@"limbo"];
    
    cell.avatarBadgeLabel.text = @"2";
    
    cell.avatarDateLabel.text = @"6月16日";
    
    cell.avatarTitleLabel.text = @"天陨";
    
    cell.avatarMessageLabel.text = @"雪念飞叶";
    
    cell.showBadge = NO;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
