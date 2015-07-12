//
//  MainViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "MainViewController.h"
#import "DNADef.h"
#import "ListCell.h"
#import "WYPopoverController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MainViewController
{
    UITableView *mainTableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightButton];
    //    [self setupMainTableView];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    [bu setTitle:@"open" forState:UIControlStateNormal];
    [bu setBackgroundColor:[UIColor redColor]];
    bu.frame = CGRectMake(100, 100, 100, 30);
    [bu addTarget:self action:@selector(opens) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];


}

- (void)opens
{
    NSLog(@"opens");
    
    
    BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    NSLog(@"isCameraSupport:%d", isCameraSupport);
    
    BOOL isPhotoLibrarySupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    NSLog(@"isPhotoLibrarySupport:%d", isPhotoLibrarySupport);
    
    BOOL isSavedPhotosAlbum = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    NSLog(@"isSavedPhotosAlbum:%d", isSavedPhotosAlbum);
    
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
    [self.navigationController presentViewController:imagePickerController animated:YES completion:^{
    
    }];
}

- ( void )imagePickerController:( UIImagePickerController *)picker didFinishPickingMediaWithInfo:( NSDictionary *)info
{
    
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.avatarImageView.image = [UIImage imageNamed:@"limbo"];
    
    cell.avatarBadgeLabel.text = @"2";
    
    cell.avatarDateLabel.text = @"6月16日";
    
    cell.avatarTitleLabel.text = @"天陨";
    
    cell.avatarMessageLabel.text = @"雪念飞叶";
    
    cell.showBadge = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
