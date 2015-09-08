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
#define playButtonMargin 10
#define floatCommentHeight 35

#define videoDetailIndex 1000

#define detailTitleFontSize 14


#define maxContentHeight screenHeight-segmentedCtrlHeight-floatCommentHeight-statusBarWithNavigationBarHeight

#define minContentHeight screenHeight-displayVideoHeight-segmentedCtrlHeight-floatCommentHeight-statusBarWithNavigationBarHeight

@interface DisplayViewController ()<clickCellDelegate>

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
    
    UIActivityIndicatorView *movieActivityIndicator;
    
    UILabel *videoName;
    
    UIButton *videoPlayButton;
    
    UIButton *plusFunButton;
    
    UITextField *firstResponderField;
    
    float keyboardhight;
    
    PannelTableView *reviewPannel;
    
    PannelTableView *commentPannel;
    
    PannelTableView *worksPannel;
    
    UIScrollView *detailsPannel;
    
    /** 需要计算高度UILabel的数组 */
    NSMutableArray* heightLablesInDetailsView;
    
    UIView *moveLine;
    
    CGFloat lineWith;
    
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
    
    [self setupSegmentedCtrl];
    
    [self setupContentScrollView];
    
    [self setupFloatCommentView];
    
    if (_videoData != nil) {
        [self refreshData];
    }else if(_memberId != nil){
        NSLog(@"%@", _memberId);
        NSLog(@"hello");
    }else if(_videoId != nil){
        [self requstApi];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    [self registerForMovieNotifacations];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (moviePlayer!=nil && moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        NSLog(@"moviePlayer nil");
        [moviePlayer stop];
        moviePlayer = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)requstApi
{
    
//    [self showHUB];
    
    RequestService *request = [RequestService videoIdRequestPostData:[RequstVideoId requstVideoWithVideoId:_videoId]];

    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
//        [self hideHUB];
        
        ResponseVideo *responseData = [ResponseVideo objectWithKeyValues:[request responseJSONObject]];
        NSLog(@"success");
        
        _videoData = responseData;
        
        [self refreshData];
        
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"failure");
        NSLog(@"%@", [[request responseJSONObject] objectForKey:@"code"]);
        
    }];
    
}

-(void) setupMainScrollView
{
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    mainScrollView.delegate = self;
    mainScrollView.bounces = NO;
    mainScrollView.contentSize = CGSizeMake(screenWidth, screenHeight+displayVideoHeight);
    [self.view addSubview:mainScrollView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
//    [mainScrollView addGestureRecognizer:recognizer];
    
}

-(void) setupVideoView
{

    moviePlayer = [[MPMoviePlayerController alloc] init];
    
    [mainScrollView addSubview:moviePlayer.view];
    
    moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    
    moviePlayer.controlStyle = MPMovieControlStyleNone;

    [moviePlayer.view setFrame:CGRectMake(0, 0, screenWidth, displayVideoHeight)];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchMoviePlayerView)];
    [moviePlayer.view addGestureRecognizer:recognizer];

    videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, displayVideoHeight)];
    [moviePlayer.view addSubview:videoView];
    
    videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, statusBarHeight/2, CGRectGetWidth(videoView.frame), displayVideoHeight-statusBarHeight)];
    videoImageView.image = [UIImage imageNamed:@"video_bg"];
    videoImageView.contentMode = UIViewContentModeScaleAspectFill;

    [videoView addSubview:videoImageView];
    
    movieActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:videoImageView.frame];
    movieActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [moviePlayer.view addSubview:movieActivityIndicator];

    [self setupVideoStateBar];
    
}


-(void) setupVideoStateBar
{
    
    videoStateBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(videoView.frame)-displayVideoStateBarHeight, CGRectGetWidth(videoView.frame), displayVideoStateBarHeight)];
    videoStateBar.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    [moviePlayer.view addSubview:videoStateBar];

    videoPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    videoPlayButton.backgroundColor = [UIColor redColor];
    videoPlayButton.frame = CGRectMake(CGRectGetWidth(videoStateBar.frame)-playButtonHeight-playButtonMargin, (CGRectGetHeight(videoStateBar.frame)-playButtonHeight)/2, playButtonHeight, playButtonHeight);
    [videoPlayButton setBackgroundImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
    [videoPlayButton addTarget:self action:@selector(videoPlay) forControlEvents:UIControlEventTouchUpInside];
    [videoStateBar addSubview:videoPlayButton];
    
//    plusFunButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    plusFunButton.frame = CGRectMake(CGRectGetMinX(videoPlayButton.frame)-playButtonHeight-playButtonMargin, (CGRectGetHeight(videoStateBar.frame)-playButtonHeight)/2, playButtonHeight, playButtonHeight);
//    [plusFunButton setBackgroundImage:[UIImage imageNamed:@"icon_plus_fan"] forState:UIControlStateNormal];
//    [videoStateBar addSubview:plusFunButton];
    
    videoName = [[UILabel alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(videoStateBar.frame)-(playButtonHeight-10))/2, CGRectGetWidth(videoStateBar.frame)-CGRectGetWidth(videoPlayButton.frame)-30, playButtonHeight-10)];
//    videoName.backgroundColor = [UIColor yellowColor];
    videoName.font = [UIFont systemFontOfSize:16];
    videoName.textColor = [UIColor whiteColor];
    [videoStateBar addSubview:videoName];
    
}

- (void)videoPlay
{
    [movieActivityIndicator startAnimating];
    if (moviePlayer.isPreparedToPlay || moviePlayer.loadState == MPMovieLoadStatePlayable || moviePlayer.loadState == MPMovieLoadStatePlaythroughOK) {
        if (moviePlayer.playbackState == MPMoviePlaybackStatePaused || moviePlayer.playbackState == MPMoviePlaybackStateStopped) {

            [moviePlayer play];
            [UIView animateWithDuration:0.3 animations:^{
                videoStateBar.alpha = 0;
                videoImageView.alpha = 0;
            }];
        }else if(moviePlayer.playbackState == MPMoviePlaybackStatePlaying){
            [moviePlayer pause];
        }else{
            [moviePlayer stop];
        }
    }else{
        [moviePlayer prepareToPlay];
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
    
    lineWith = CGRectGetWidth(segmentedCtrl.frame)/segmentedCtrl.numberOfSegments;
    
    moveLine = [[UIView alloc] initWithFrame:CGRectMake(_pannelIndex*lineWith, CGRectGetHeight(segmentedCtrl.frame)-1, lineWith, 1)];
    moveLine.backgroundColor = defaultTabBarTitleColor;
    [segmentedCtrl addSubview:moveLine];
    
    
}

- (void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
    
    [contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(contentScrollView.frame) * index, 0) animated:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        [moveLine moveToHorizontal:index * lineWith toVertical:CGRectGetMinY(moveLine.frame)];
    }];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:mainScrollView]) {
        [self mainScrollViewOffset];
    }else if ([scrollView isEqual:contentScrollView]) {
        NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
        segmentedCtrl.selectedSegmentIndex = index;
        [UIView animateWithDuration:0.3 animations:^{
            [moveLine moveToHorizontal:index * lineWith toVertical:CGRectGetMinY(moveLine.frame)];
        }];
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
        [reviewPannel setHeight:height];
        [commentPannel setHeight:height];
        [detailsPannel setHeight:height];
        [worksPannel setHeight:height];
    }];
}

-(void) setupContentScrollView
{
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, displayVideoHeight+segmentedCtrlHeight, screenWidth, minContentHeight)];
    contentScrollView.contentSize = CGSizeMake(CGRectGetWidth(contentScrollView.frame)*4, CGRectGetHeight(contentScrollView.frame));
    contentScrollView.delegate = self;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
//    contentScrollView.bounces = NO;
    [mainScrollView addSubview:contentScrollView];
    
    
    reviewPannel = [[PannelTableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    reviewPannel.cellType = kCellListComment;
    reviewPannel.pannelType = kDisplayPannelReview;
    [contentScrollView addSubview:reviewPannel];
    
    commentPannel = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    commentPannel.cellType = kCellListComment;
    commentPannel.pannelType = kDisplayPannelComments;
    [contentScrollView addSubview:commentPannel];
    
    detailsPannel = [[UIScrollView alloc] initWithFrame:CGRectMake(screenWidth*2, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    detailsPannel.backgroundColor = [UIColor whiteColor];
    [contentScrollView addSubview:detailsPannel];
    
    worksPannel = [[PannelTableView alloc] initWithFrame:CGRectMake(screenWidth*3, 0, screenWidth, CGRectGetHeight(contentScrollView.frame))];
    worksPannel.cellType = kCellListVideo;
    worksPannel.pannelType = kDisplayPannelWorks;
    worksPannel.delegate = self;
    [contentScrollView addSubview:worksPannel];
    
    
    [contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(contentScrollView.frame) * _pannelIndex, 0)];

}

- (void)setupDetailsView
{
    if (heightLablesInDetailsView == nil) {
        heightLablesInDetailsView = [[NSMutableArray alloc] init];
    }else{
        [heightLablesInDetailsView removeAllObjects];
    }
    
    if(detailsPannel.subviews.count>0){
        for (UIView *subview in detailsPannel.subviews) {
            [subview removeFromSuperview];
        }
    }
    
    NSArray* detailInfoTitle = @[@"视频标题", @"视频描述", @"播放次数", @"点赞人数", @"视频大小", @"发布时间"];
    
    for (int i = 0; i < detailInfoTitle.count; i++) {
        
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMinY(detailsPannel.frame)+10+i*25, 70, 16)];
        labelTitle.font = [UIFont systemFontOfSize:detailTitleFontSize];
        labelTitle.textColor = [UIColor grayColor];
        labelTitle.textAlignment = NSTextAlignmentRight;
        labelTitle.text = [NSString stringWithFormat:@"%@：",[detailInfoTitle objectAtIndex:i]];
        [detailsPannel addSubview:labelTitle];
        
        UILabel *labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(labelTitle.frame)+10, CGRectGetMinY(detailsPannel.frame)+10+i*25, CGRectGetWidth(detailsPannel.frame)-CGRectGetWidth(labelTitle.frame)-15, 16)];
        labelDesc.font = [UIFont systemFontOfSize:detailTitleFontSize];
        labelDesc.textAlignment = NSTextAlignmentLeft;
        labelDesc.textColor = [UIColor lightGrayColor];
        NSString *descString;
        switch (i) {
            case 0:
                descString = _videoData.name;
                break;
            case 1:
                descString = _videoData.desc;
                break;
            case 2:
                descString = [_videoData.playTimes stringValue];
                break;
            case 3:
                descString = [_videoData.likeTimes stringValue];
                break;
            case 4:
                descString = [DisplayUtil convertWithBytes:[_videoData.totalBytes floatValue]];
                break;
            case 5:
                descString = [DisplayUtil getDateStringWithDate:_videoData.publishTime withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                break;
            default:
                descString = @"";
                break;
        }
        labelDesc.text = descString;
        labelDesc.numberOfLines = 0;
        int tagIdx = (int)videoDetailIndex;
        labelDesc.tag = tagIdx+i;
        [detailsPannel addSubview:labelDesc];
        
        [heightLablesInDetailsView addObject:[NSMutableArray arrayWithObjects:labelTitle, labelDesc, nil]];
        
    }
    
    [self refreshDetailLayout];
}

-(void)refreshDetailLayout
{
    CGFloat offset = 10;
    for (int i = 0; i < [heightLablesInDetailsView count]; i++) {
            CGFloat maxHeight = 0;
            NSMutableArray *group = [heightLablesInDetailsView objectAtIndex:i];
            for (int j = 0; j < [group count]; j++) {
                UILabel *label = [group objectAtIndex:j];
                CGSize size = [DisplayUtil getSize:detailTitleFontSize withString:label.text withWidth:CGRectGetWidth(label.frame)];
                label.frame = CGRectMake(CGRectGetMinX(label.frame), offset, CGRectGetWidth(label.frame), size.height);
                maxHeight = MAX(maxHeight, size.height+4);
            }
            offset+=maxHeight+4;
    }
    detailsPannel.contentSize = CGSizeMake(CGRectGetWidth(detailsPannel.frame), offset);
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
    [UIView animateWithDuration:0.3 animations:^{
        if (videoStateBar.alpha > 0) {
            videoStateBar.alpha = 0;
        }else{
            videoStateBar.alpha = 1;
        }
    }];
    [firstResponderField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    firstResponderField = textField;
    [UIView animateWithDuration:0.3 animations:^{
        [floatCommentView moveToHorizontal:0 toVertical:screenHeight-statusBarWithNavigationBarHeight-252-floatCommentHeight];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [floatCommentView moveToHorizontal:0 toVertical:screenHeight-floatCommentHeight-statusBarWithNavigationBarHeight];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)getCellData:(id)data
{
    ResponseVideo *videoData = (ResponseVideo *)data;
    if (![_videoId isEqualToString:videoData.id]) {
        _videoData = videoData;
        _videoId = videoData.id;
        [self refreshData];
    }

}

- (void)refreshData
{
    NSLog(@"refreshData");
    
    if (moviePlayer.playbackState != MPMoviePlaybackStateStopped) {
        [moviePlayer stop];
    }
    
    [videoImageView sd_setImageWithURL:_videoData.picUrl placeholderImage:[UIImage imageNamed:@"video_bg"]];
    
    videoName.text = _videoData.name;

    [moviePlayer setContentURL:_videoData.videoUrl];

    reviewPannel.memberId = _videoData.memberId;
    reviewPannel.videoId = _videoData.id;
    [reviewPannel sendReviewRequest];
    
    commentPannel.memberId = _videoData.memberId;
    commentPannel.videoId = _videoData.id;
    [commentPannel sendCommentsRequest];
    
    [self setupDetailsView];
    
    worksPannel.memberId = _videoData.memberId;
    worksPannel.videoId = _videoData.id;
    [worksPannel sendWorksRequest];
    
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

- (void)registerForMovieNotifacations
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)  //媒体播放完成或用户手动退出
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieDidChangeCallback:)    //当前播放的媒体内容发生改变
                                                 name:MPMoviePlayerNowPlayingMovieDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieStateDidChangeCallback:)    //播放状态改变，可配合playbakcState属性获取具体状态
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieLoadStateDidChangeCallback:)    //媒体网络加载状态改变体状态
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
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

- (void)movieFinishedCallback:(NSNotification *) notification
{
    NSLog(@"视频播放完成");
    
    [UIView animateWithDuration:0.3 animations:^{
        videoImageView.alpha = 1;
        videoStateBar.alpha = 1;
    } completion:^(BOOL finished) {
        [moviePlayer stop];
    }];
    
}

- (void)movieDidChangeCallback:(NSNotification *) notification
{
    NSLog(@"内容有修改");
    [movieActivityIndicator startAnimating];
}

- (void)movieStateDidChangeCallback:(NSNotification *) notification
{
    [movieActivityIndicator stopAnimating];
    switch (moviePlayer.playbackState) {
        case MPMoviePlaybackStateInterrupted:
            //中断
            NSLog(@"视频中断");
            break;
        case MPMoviePlaybackStatePaused:
            //暂停
            NSLog(@"视频暂停");
//            [movieActivityIndicator startAnimating];
            break;
        case MPMoviePlaybackStatePlaying:
            //播放中
            [movieActivityIndicator stopAnimating];
            NSLog(@"视频播放中");
            break;
        case MPMoviePlaybackStateSeekingBackward:
            //后退
            NSLog(@"视频后退");
            break;
        case MPMoviePlaybackStateSeekingForward:
            //快进
            NSLog(@"视频快进");
            break;
        case MPMoviePlaybackStateStopped:
            //停止
            NSLog(@"视频停止");
            break;
        default:
            break;
    }
    
}

- (void)movieLoadStateDidChangeCallback:(NSNotification *) notification
{
    switch (moviePlayer.loadState) {
        case MPMovieLoadStateUnknown:
            //未知状态
            NSLog(@"未知状态");
            [movieActivityIndicator stopAnimating];
            break;
        case MPMovieLoadStatePlayable:
            //可播状态
            NSLog(@"可播状态");
            [movieActivityIndicator startAnimating];
            break;
        case MPMovieLoadStatePlaythroughOK:
            //这种状态如果shouldAutoPlay为YES将自动播放
            //加载完成状态
            NSLog(@"这种状态如果shouldAutoPlay为YES将自动播放");
            [movieActivityIndicator startAnimating];
            break;
        case MPMovieLoadStateStalled:
            //停滞状态  还在加载状态
            NSLog(@"停滞状态");
            [movieActivityIndicator startAnimating];
            break;
        default:
            NSLog(@"ok");
            [UIView animateWithDuration:0.3 animations:^{
                videoImageView.alpha = 0;
                videoStateBar.alpha = 0;
            } completion:^(BOOL finished) {
                [movieActivityIndicator stopAnimating];
            }];
            break;
    }
}
@end
