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
#import "PopoverViewController.h"

@interface DNABaseViewController ()<WYPopoverControllerDelegate, popoverClickDelegate>
{
    MBProgressHUD* HUD;
    int staticHUBCounter;
    UIBarButtonItem *rightButton;
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
    [self setupRightButton];

    WYPopoverTheme *theme = [WYPopoverTheme themeForIOS8];
    [WYPopoverController setDefaultTheme:theme];

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

- (void) setupRightButton
{
    rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(popoverAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void) popoverAction:(id)sender
{
    PopoverViewController *popoverCtrl =[[PopoverViewController alloc] init];
    popoverCtrl.delegate = self;
    popoverController = [[WYPopoverController alloc] initWithContentViewController:popoverCtrl];
    [popoverController setPopoverContentSize:popoverSize];
    popoverController.delegate = self;
    [popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES];
    
}

- (void)getPopoverClickType:(NSString *)type
{
    [self showTips:[NSString stringWithFormat:@"选择了:%@", type]];
    [popoverController dismissPopoverAnimated:NO];
}

- (void)animView:(UIView *)view withHidden:(BOOL)isShow
{
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = isShow ? 0 : 0.9;
    }];
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
    [HUD hide:YES afterDelay:1l];
    
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


#pragma mark popover delegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    NSLog(@"hel");
    *value = 0;
}

@end
