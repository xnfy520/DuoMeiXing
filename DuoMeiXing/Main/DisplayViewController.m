//
//  DisplayViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/16.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DisplayViewController.h"
#import "DNADef.h"
#import "PannelTableView.h"

#define displayVideoHeight 150
#define segmentedCtrlHeight 35

@interface DisplayViewController ()<UIScrollViewDelegate>

@end

@implementation DisplayViewController
{
    UIView *videoView;
    UISegmentedControl *segmentedCtrl;
    UIScrollView *contentScrollView;
    UIView *floatCommentView;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupVideoView];
    
    [self setupSegmentedCtrl];
    
    [self setupContentScrollView];
    
    [self setupFloatCommentView];
}

-(void) setupVideoView
{
    videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, displayVideoHeight)];
    videoView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:videoView];
}

-(void) setupSegmentedCtrl
{
    NSArray *segmentList = @[@"点评", @"评论", @"信息", @"作品"];
    segmentedCtrl = [[UISegmentedControl alloc] initWithItems:segmentList];
    segmentedCtrl.tintColor = [UIColor clearColor];
    segmentedCtrl.backgroundColor = [UIColor cyanColor];
    segmentedCtrl.selectedSegmentIndex = 0;
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                             NSForegroundColorAttributeName: [UIColor orangeColor]};
    
    [segmentedCtrl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                               NSForegroundColorAttributeName: [UIColor blackColor]};
    
    [segmentedCtrl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [segmentedCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [segmentedCtrl setFrame:CGRectMake(0, displayVideoHeight, screenWidth, segmentedCtrlHeight)];
    [self.view addSubview:segmentedCtrl];
}

- (void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
    
    [contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(contentScrollView.frame) * index, 0) animated:YES];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:contentScrollView]) {
        NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
        segmentedCtrl.selectedSegmentIndex = index;
    }
}

-(void) setupContentScrollView
{
    
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, displayVideoHeight+segmentedCtrlHeight, screenWidth, screenHeight-displayVideoHeight-statusBarWithNavigationBarHeight-segmentedCtrlHeight-navigationBarHeight)];
    contentScrollView.contentSize = CGSizeMake(CGRectGetWidth(contentScrollView.frame)*4, CGRectGetHeight(contentScrollView.frame));
    contentScrollView.delegate = self;
    contentScrollView.backgroundColor = [UIColor yellowColor];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.bounces = NO;
    [self.view addSubview:contentScrollView];
    
    
    PannelTableView *panel1 = [[PannelTableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    [contentScrollView addSubview:panel1];
    
    PannelTableView *panel2 = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    [contentScrollView addSubview:panel2];
    
    PannelTableView *panel4 = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth*3, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    panel4.identifier = @"video";
    [contentScrollView addSubview:panel4];

}

-(void) setupFloatCommentView
{
    floatCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-statusBarWithNavigationBarHeight-navigationBarHeight, screenWidth, navigationBarHeight)];
    floatCommentView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:floatCommentView];
}

@end
