//
//  PhotographAlbumCategoryViewController.m
//  DuoMeiXing
//
//  Created by 雪念飞叶 on 15/7/29.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PhotographAlbumCategoryViewController.h"
#import "DNADef.h"
#import "PhotographAlbumViewController.h"
#import "ListCell.h"
#import "DisplayViewController.h"

@interface PhotographAlbumCategoryViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mainTableView;
    NSArray *mainOptionData;
}
@end

@implementation PhotographAlbumCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightButton];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTableView];
    
    [self setupInsetsTableView:mainTableView];
    
    mainOptionData = @[
                       @{
                           @"title":@"民谣吉他教材",
                           @"icon":@"home_disc_teaching_tgita",
                           @"ctrl":@"tgita",
                           @"list":@[]
                           },
                       @{
                           @"title":@"钢琴教材",
                           @"icon":@"home_disc_teaching_piano",
                           @"ctrl":@"piano",
                           @"list":@[]
                           },
                       @{
                           @"title":@"电吉他教材",
                           @"icon":@"home_disc_teaching_egita",
                           @"ctrl":@"egita",
                           @"list":@[]
                           },
                       @{
                           @"title":@"小提琴教材",
                           @"icon":@"home_disc_teaching_violin",
                           @"ctrl":@"violin",
                           @"list":@[]
                           }
                       ];

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (35-25)/2, 25, 25)];
    NSString *icon = [[mainOptionData objectAtIndex:section] objectForKey:@"icon"];
    headerIcon.image = [UIImage imageNamed:icon];
    [headerView addSubview:headerIcon];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerIcon.frame)+5, (35-15)/2, screenWidth-40*2, 15)];
    headerTitle.font = [UIFont boldSystemFontOfSize:14];
    headerTitle.text = [[mainOptionData objectAtIndex:section] objectForKey:@"title"];
    [headerView addSubview:headerTitle];
    
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [headerButton setImage:[[[UIImage imageNamed:@"iosArrowRight"] imageToSize:CGSizeMake(8, 21)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    headerButton.contentMode = UIViewContentModeCenter;
    switch (section) {
        case 0:
            headerButton.tag = kPhotographAlbumTypeTguita;
            break;
        case 1:
            headerButton.tag = kPhotographAlbumTypePiano;
            break;
        case 2:
            headerButton.tag = kPhotographAlbumTypeEguita;
            break;
        case 3:
            headerButton.tag = kPhotographAlbumTypeViolin;
            break;
        default:
            headerButton.tag = kPhotographAlbumTypeTguita;
            break;
    }
    [headerButton addTarget:self action:@selector(toCategory:) forControlEvents:UIControlEventTouchUpInside];
    headerButton.frame  = CGRectMake(screenWidth-25-5, (35-25)/2, 25, 25);
    [headerView addSubview:headerButton];

    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return listCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mainOptionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainOptionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    cell.cellListType = kCellListVideo;
    
    cell.cellImageView.image = [UIImage imageNamed:@"xianjian"];
    
    cell.cellBadgeLabel.text = @"2";
    
    cell.cellDateLabel.text = @"6月16日";
    
    cell.cellTitleLabel.text = @"天陨";
    
    cell.cellDetailLabel.text = @"雪念飞叶";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];

    DisplayViewController *displayCtrl = [[DisplayViewController alloc] init];
    displayCtrl.haveViedo = YES;
    [self.navigationController pushViewController:displayCtrl animated:YES];

}

- (void)toCategory:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    PhotographAlbumViewController *photographAlbumCtrl = [[PhotographAlbumViewController alloc] init];
    NSLog(@"%ld", (long)button.tag);
    photographAlbumCtrl.listType = button.tag;
    [self.navigationController pushViewController:photographAlbumCtrl animated:YES];
}

@end
