//
//  DisplayViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/16.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DisplayViewController.h"

#import "PannelTableView.h"
#import "SubmitButton.h"
#import <MediaPlayer/MediaPlayer.h>

#define displayVideoHeight 175
#define displayVideoStateBarHeight 35
#define segmentedCtrlHeight 35
#define playButtonHeight 25
#define playButtonMargin 15
#define floatCommentHeight 35


#define maxContentHeight screenHeight-segmentedCtrlHeight-floatCommentHeight-statusBarWithNavigationBarHeight

#define minContentHeight screenHeight-displayVideoHeight-segmentedCtrlHeight-floatCommentHeight-statusBarWithNavigationBarHeight

@interface DisplayViewController ()

@end

@implementation DisplayViewController
{
    UIView *videoView;
    UIImageView * videoImageView;
    UIView *videoStateBar;
    UISegmentedControl *segmentedCtrl;
    
    UIScrollView *mainScrollView;
    
    UIScrollView *contentScrollView;
    UIView *floatCommentView;
    
    MPMoviePlayerController *moviePlayer;
    
    UILabel *videoNickname;
    
    UIButton *videoPlayButton;
    
    UIButton *plusFunButton;
    
    UITextField *firstResponderField;
    
    float keyboardhight;
    
    PannelTableView *panel1;
    
    PannelTableView *panel2;
    
    PannelTableView *panel4;
    
}

-(void) viewDidLoad
{
    [super viewDidLoad];

    self.title = @"天陨";
    
    [self setViewRectEdge];
    
//    self.navigationController.navigationBarHidden = YES;
    
//    self.view.backgroundColor = [UIColor darkGrayColor];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tmbg"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self setupMainScrollView];
    
    [self setupVideoView];
    
    [self setupVideoStateBar];
    
    [self setupSegmentedCtrl];
    
    [self setupContentScrollView];
    
    [self setupFloatCommentView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (moviePlayer!=nil && moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        [moviePlayer stop];
        moviePlayer = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void) setupMainScrollView
{
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    mainScrollView.delegate = self;
    mainScrollView.bounces = NO;
    mainScrollView.contentSize = CGSizeMake(screenWidth, screenHeight+displayVideoHeight);
    [self.view addSubview:mainScrollView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [mainScrollView addGestureRecognizer:recognizer];
    
}

-(void) setupVideoView
{

//    NSString *file = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:file];
    if (moviePlayer == nil) {
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:_videoData.videoUrl];
    }else {
        [moviePlayer setContentURL:_videoData.videoUrl];
    }
   
    moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    
    moviePlayer.controlStyle = MPMovieControlStyleNone;
    
    moviePlayer.shouldAutoplay = NO;
    
    [moviePlayer prepareToPlay];

    [moviePlayer.view setFrame:CGRectMake(0, 0, screenWidth, displayVideoHeight)];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchMoviePlayerView)];
    [moviePlayer.view addGestureRecognizer:recognizer];
    
    [mainScrollView addSubview:moviePlayer.view];
    
    videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, displayVideoHeight)];
//    videoView.backgroundColor = [UIColor blackColor];
    [moviePlayer.view addSubview:videoView];
    
    videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, statusBarHeight/2, CGRectGetWidth(videoView.frame), displayVideoHeight-statusBarHeight)];
//    videoImageView.hidden = _haveViedo;
    [videoImageView sd_setImageWithURL:_videoData.picUrl placeholderImage:[UIImage imageNamed:@"video_bg"]];
    videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [videoView addSubview:videoImageView];
    
}

-(void) setupVideoStateBar
{
    
    videoStateBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(videoView.frame)-displayVideoStateBarHeight, CGRectGetWidth(videoView.frame), displayVideoStateBarHeight)];
    videoStateBar.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    [videoView addSubview:videoStateBar];

    videoPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    videoPlayButton.frame = CGRectMake(CGRectGetWidth(videoStateBar.frame)-playButtonHeight-playButtonMargin, (CGRectGetHeight(videoStateBar.frame)-playButtonHeight)/2, playButtonHeight, playButtonHeight);
    [videoPlayButton setBackgroundImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
    [videoPlayButton addTarget:self action:@selector(videoPlay) forControlEvents:UIControlEventTouchUpInside];
    [videoStateBar addSubview:videoPlayButton];
    
    plusFunButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusFunButton.frame = CGRectMake(CGRectGetMinX(videoPlayButton.frame)-playButtonHeight-playButtonMargin, (CGRectGetHeight(videoStateBar.frame)-playButtonHeight)/2, playButtonHeight, playButtonHeight);
    [plusFunButton setBackgroundImage:[UIImage imageNamed:@"icon_plus_fan"] forState:UIControlStateNormal];
//    [videoStateBar addSubview:plusFunButton];
    
    videoNickname = [[UILabel alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(videoStateBar.frame)-(playButtonHeight-10))/2, CGRectGetWidth(videoStateBar.frame)/2, playButtonHeight-10)];
    videoNickname.text = _videoData.name;
    videoNickname.font = [UIFont systemFontOfSize:17];
    videoNickname.textColor = [UIColor whiteColor];
    [videoStateBar addSubview:videoNickname];
    
    
//    if (![videoImageView isHidden]) {
//        [videoStateBar setHidden:YES];
//    }
    
}

- (void)videoPlay
{
    if (moviePlayer.isPreparedToPlay) {
        if (moviePlayer.playbackState == MPMoviePlaybackStatePaused || moviePlayer.playbackState == MPMoviePlaybackStateStopped) {
            [moviePlayer play];
            videoStateBar.alpha = 0;
            videoImageView.alpha = 0;
        }else if(moviePlayer.playbackState == MPMoviePlaybackStatePlaying){
            [moviePlayer pause];
        }
    }
}

-(void) setupSegmentedCtrl
{
    NSArray *segmentList = @[@"点评", @"评论", @"信息", @"作品"];
    segmentedCtrl = [[UISegmentedControl alloc] initWithItems:segmentList];
    segmentedCtrl.tintColor = [UIColor clearColor];
    segmentedCtrl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    segmentedCtrl.selectedSegmentIndex = _pannelIndex;
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                             NSForegroundColorAttributeName: defaultTabBarTitleColor};
    
    [segmentedCtrl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                               NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    
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

    [UIView animateWithDuration:0.3 animations:^{
        [contentScrollView setHeight:height];
        [contentScrollView setContentSize:CGSizeMake(contentScrollView.contentSize.width, height)];
        [panel1 setHeight:height];
        [panel2 setHeight:height];
        [panel4 setHeight:height];
        
        
    } completion:^(BOOL finished) {
        //finished判断动画是否完成
        if (finished) {
            NSLog(@"finished");
        }
    }];

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
    panel1.cellType = kCellListComment;
    panel1.pannelType = kDisplayPannelReview;
    panel1.memberId = _videoData.memberId;
    panel1.videoId = _videoData.id;
    [panel1 sendCommentsRequest];
    [contentScrollView addSubview:panel1];
    
    panel2 = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    panel2.cellType = kCellListComment;
    panel2.pannelType = kDisplayPannelComments;
    panel2.memberId = _videoData.memberId;
    panel2.videoId = _videoData.id;
    [panel2 sendCommentsRequest];
    [contentScrollView addSubview:panel2];
    
    panel4 = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth*3, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    panel4.cellType = kCellListVideo;
    panel4.pannelType = kDisplayPannelWorks;
    panel4.memberId = _videoData.memberId;
    panel4.videoId = _videoData.id;
//    [panel4 sendRequest];
    [panel4 sendWorksRequest];
    [contentScrollView addSubview:panel4];

}

-(void) setupFloatCommentView
{
    floatCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-floatCommentHeight-statusBarWithNavigationBarHeight, screenWidth, floatCommentHeight)];
    floatCommentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:floatCommentView];
    
    UITextField *commentField = [[UITextField alloc] initWithFrame:CGRectMake(3, 3, CGRectGetWidth(floatCommentView.frame)-68, floatCommentHeight-6)];
    commentField.borderStyle = UITextBorderStyleRoundedRect;
    commentField.delegate = self;
    commentField.placeholder = @"输入评论";
    commentField.clearButtonMode=UITextFieldViewModeWhileEditing;
    commentField.returnKeyType = UIReturnKeyDefault;
    [floatCommentView addSubview:commentField];
    
    SubmitButton *submitButton = [[SubmitButton alloc] initWithFrame: CGRectMake(CGRectGetWidth(floatCommentView.frame)-62, 3, 58, floatCommentHeight-6) withTitle:@"提交" withBackgroundColor:defaultTabBarTitleColor];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [floatCommentView addSubview:submitButton];
    
}

- (void)touchScrollView
{
    [firstResponderField resignFirstResponder];
}

- (void)touchMoviePlayerView
{

    [UIView animateWithDuration:0.1 animations:^{
        
//        if (![firstResponderField isEditing] && [videoImageView isHidden]) {
            if (videoStateBar.alpha > 0) {
                videoStateBar.alpha = 0;
            }else{
                videoStateBar.alpha = 1;
            }
//        }
        
        
    } completion:^(BOOL finished) {
        //finished判断动画是否完成
        if (finished) {
//            NSLog(@"finished");
        }
    }];
    
    [firstResponderField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    firstResponderField = textField;
    [UIView animateWithDuration:0.3 animations:^{
        [floatCommentView moveToHorizontal:0 toVertical:screenHeight-statusBarWithNavigationBarHeight-252-floatCommentHeight];
    } completion:^(BOOL finished) {
        //finished判断动画是否完成
        if (finished) {
            NSLog(@"finished");
        }
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [floatCommentView moveToHorizontal:0 toVertical:screenHeight-floatCommentHeight-statusBarWithNavigationBarHeight];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    if(kbSize.height == 216)
    {
        keyboardhight = 0;
    }
    else
    {
        keyboardhight = 36;   //252 - 216 系统键盘的两个不同高度
    }
    //输入框位置动画加载
    NSLog(@"hight_hitht:%f",keyboardhight);
    keyboardhight = kbSize.height;
    [self begainMoveUpAnimation:keyboardhight];
}

- (void)begainMoveUpAnimation:(float)height
{
    NSLog(@"--->:%f",height);
    
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
}

#pragma mark - View Auto-Rotation

// 重写该方法，控制该视图控制器只支持横屏显示
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
