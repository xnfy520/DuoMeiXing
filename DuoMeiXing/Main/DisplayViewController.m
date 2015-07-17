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


#define displayVideoHeight 200
#define segmentedCtrlHeight 35

#define maxContentHeight screenHeight-segmentedCtrlHeight-navigationBarHeight

#define minContentHeight screenHeight-displayVideoHeight-segmentedCtrlHeight-navigationBarHeight

@interface DisplayViewController ()<UIScrollViewDelegate>

@end

@implementation DisplayViewController
{
    UIView *videoView;
    UISegmentedControl *segmentedCtrl;
    
    UIScrollView *mainScrollView;
    
    UIScrollView *contentScrollView;
    UIView *floatCommentView;
    
    PannelTableView *panel1;
    
    PannelTableView *panel2;
    
    PannelTableView *panel4;
}

-(void) viewDidLoad
{
    [super viewDidLoad];

    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
    self.navigationController.navigationBarHidden = YES;
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tmbg"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self setupMainScrollView];
    
    [self setupVideoView];
    
    [self setupSegmentedCtrl];
    
    [self setupContentScrollView];
    
    [self setupFloatCommentView];
}


-(void) setupMainScrollView
{
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
//    mainScrollView.backgroundColor = [UIColor blueColor];
    mainScrollView.delegate = self;
    mainScrollView.bounces = NO;
    mainScrollView.contentSize = CGSizeMake(screenWidth, screenHeight+displayVideoHeight);
    [self.view addSubview:mainScrollView];
}

-(void) setupVideoView
{
    videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, displayVideoHeight)];
    videoView.backgroundColor = [UIColor darkGrayColor];
    [mainScrollView addSubview:videoView];
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
    
    [mainScrollView addSubview:segmentedCtrl];
    
    
}

- (void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
    
    [contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(contentScrollView.frame) * index, 0) animated:YES];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:mainScrollView]) {
        [self mainScrollViewOffset];
    }else if ([scrollView isEqual:contentScrollView]) {
        NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
        segmentedCtrl.selectedSegmentIndex = index;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:mainScrollView]) {
        [self mainScrollViewOffset];
    }
}

-(void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ([scrollView isEqual:mainScrollView]) {
        [self mainScrollViewOffset];
    }
}

- (void)mainScrollViewOffset
{
    if (mainScrollView.contentOffset.y>displayVideoHeight/2) {
        [mainScrollView setContentOffset:CGPointMake(0, CGRectGetMinY(segmentedCtrl.frame)) animated:YES];
        [self setPanelWithHeight:maxContentHeight];
    }else{
        [mainScrollView setContentOffset:CGPointZero animated:YES];
        [self setPanelWithHeight:minContentHeight];
    }
}

- (void)setPanelWithHeight:(CGFloat)height
{
    [contentScrollView setHeight:height];
    [contentScrollView setContentSize:CGSizeMake(contentScrollView.contentSize.width, height)];
    [panel1 setHeight:height];
    [panel2 setHeight:height];
    [panel4 setHeight:height];
}

-(void) setupContentScrollView
{
    //CGRectGetHeight(mainScrollView.frame)-segmentedCtrlHeight-navigationBarHeight
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, displayVideoHeight+segmentedCtrlHeight, screenWidth, minContentHeight)];
    contentScrollView.contentSize = CGSizeMake(CGRectGetWidth(contentScrollView.frame)*4, CGRectGetHeight(contentScrollView.frame));
    contentScrollView.delegate = self;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
//    contentScrollView.bounces = NO;
    [mainScrollView addSubview:contentScrollView];
    
    
    panel1 = [[PannelTableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    [contentScrollView addSubview:panel1];
    
    panel2 = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    [contentScrollView addSubview:panel2];
    
    panel4 = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth*3, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    panel4.identifier = @"video";
    [contentScrollView addSubview:panel4];

}

-(void) setupFloatCommentView
{
    floatCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-navigationBarHeight, screenWidth, navigationBarHeight)];
    floatCommentView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:floatCommentView];
}

@end
