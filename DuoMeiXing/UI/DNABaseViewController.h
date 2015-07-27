//
//  DNABaseViewController.h
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DNABaseViewController : UIViewController


// showHUB/hideHUB 要配对使用 如果调用 show必须要 hide 才能消除
-(void)showHUB;
-(void)showHUBWithText:(NSString*)text;
-(void)hideHUB;

//显示 HUB 提示性错误显示，自动消失
-(void)showTips:(NSString*)msg;

- (void)setViewRectEdge;

- (void)setupRightButton;

- (void)setupInsetsTableView :(UITableView *)tableView;

- (void)mainViewWithAnimate :(BOOL)animated;

@property (nonatomic) UIImagePickerController *imagePickerController;

@end
