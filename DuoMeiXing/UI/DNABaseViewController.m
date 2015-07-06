//
//  DNABaseViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DNABaseViewController.h"
#import "DNADef.h"

@interface DNABaseViewController ()
{
    MBProgressHUD* HUD;
    int staticHUBCounter;
    UIBarButtonItem *rightButton;
    UIView *listView;
    BOOL isOpen;
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
}

- (void) setupRightButton
{
    rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(abc)];
    self.navigationItem.rightBarButtonItem = rightButton;

}

- (void) abc
{
    NSLog(@"%@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
    NSLog(@"%f", CGRectGetMaxY(self.navigationController.navigationBar.frame));

    if (isOpen) {
        isOpen = NO;
        [self animView:listView withHidden:YES];
        
    }else{
        isOpen = YES;
        [self animView:listView withHidden:NO];
    }
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
