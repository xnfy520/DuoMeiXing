//
//  DNABaseViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DNABaseViewController.h"
#import "DNADef.h"
#import "WYPopoverController.h"
#import "MineViewController.h"

@interface DNABaseViewController ()<WYPopoverControllerDelegate>
{
    MBProgressHUD* HUD;
    int staticHUBCounter;
    UIBarButtonItem *rightButton;
    UIView *listView;
    BOOL isOpen;
    WYPopoverController* popoverController;
}
@end

@implementation DNABaseViewController

-(id)init
{
    if (![super init])
        return nil;
    
    
    staticHUBCounter = 0;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    isOpen = NO;
    [self setupRightButton];

    WYPopoverTheme *theme = [WYPopoverTheme themeForIOS6];
    [WYPopoverController setDefaultTheme:theme];

    WYPopoverBackgroundView *popoverAppearance = [WYPopoverBackgroundView appearance];
    [popoverAppearance setBorderWidth:5];
    [popoverAppearance setArrowHeight:10];
    [popoverAppearance setArrowBase:20];
    
//    UIColor *greenColor = [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1];
//    
//    [WYPopoverController setDefaultTheme:[WYPopoverTheme themeForIOS7]];
//    
//    WYPopoverBackgroundView *popoverAppearance = [WYPopoverBackgroundView appearance];
//    [popoverAppearance setOverlayColor:[UIColor clearColor]];
//    [popoverAppearance setOuterCornerRadius:4];
//    [popoverAppearance setOuterShadowBlurRadius:0];
//    [popoverAppearance setOuterShadowColor:[UIColor clearColor]];
//    [popoverAppearance setOuterShadowOffset:CGSizeMake(0, 0)];
//    
//    [popoverAppearance setGlossShadowColor:[UIColor clearColor]];
//    [popoverAppearance setGlossShadowOffset:CGSizeMake(0, 0)];
//    
//    [popoverAppearance setBorderWidth:8];
//    [popoverAppearance setArrowHeight:10];
//    [popoverAppearance setArrowBase:20];
//    
//    [popoverAppearance setInnerCornerRadius:4];
//    [popoverAppearance setInnerShadowBlurRadius:0];
//    [popoverAppearance setInnerShadowColor:[UIColor clearColor]];
//    [popoverAppearance setInnerShadowOffset:CGSizeMake(0, 0)];
//    
//    [popoverAppearance setFillTopColor:greenColor];
//    [popoverAppearance setFillBottomColor:greenColor];
//    [popoverAppearance setOuterStrokeColor:greenColor];
//    [popoverAppearance setInnerStrokeColor:greenColor];

}

- (void) setupRightButton
{
    rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(abc:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    NSLog(@"%@", [self class]);
}

- (void) abc:(id)sender
{
    NSLog(@"hello");
    
    MineViewController *mine =[[MineViewController alloc] init];
//    mine.preferredContentSize = CGSizeMake(100, 100);
    
    popoverController = [[WYPopoverController alloc] initWithContentViewController:mine];
    [popoverController setPopoverContentSize:CGSizeMake(100, 100)];
    [popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES];
    
}


- (void)animView:(UIView *)view withHidden:(BOOL)isShow
{
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = isShow ? 0 : 0.9;
    }];
}

- (void)setupRightListInView:(UIView *)view
{
    float navY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    listView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth-screenWidth/2.5-25, navY, screenWidth/2.5, 100)];
    listView.backgroundColor = defaultNavigationBar;
    listView.alpha = 0;
    [view addSubview:listView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    if(HUD != nil)
    {
        [HUD removeFromSuperview];
        HUD = nil;
    }
}

-(void)showHUB
{
    if(staticHUBCounter == 0)
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    staticHUBCounter ++;
}

-(void)showHUBWithText:(NSString*)text
{
    MBProgressHUD* hub = nil;
    if(staticHUBCounter != 0){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
    hub =[MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    hub.mode = MBProgressHUDModeIndeterminate;
    hub.labelText = text;
    
    staticHUBCounter ++;
}

-(void)hideHUB
{
    staticHUBCounter --;
    if(staticHUBCounter == 0)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)showTips:(NSString*)msg
{
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
    }
    
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    
}


- (void)setupInsetsTableView :(UITableView *)tableView
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

@end
