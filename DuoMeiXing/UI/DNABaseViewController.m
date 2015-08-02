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
#import "PopoverViewController.h"
#import "QRCodeReaderViewController.h"
#import "WebViewController.h"
#import "ContactsViewController.h"

@interface DNABaseViewController ()<WYPopoverControllerDelegate, popoverClickDelegate, QRCodeReaderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[UserDataManager sharedUserDataManager] isLogin]) {
        NSLog(@"is login");
    }else{
        NSLog(@"not login");
        
        NSLog(@"%@", [self class]);
        if (![NSStringFromClass([self class]) isEqualToString:@"LoginViewController"]) {
            postEvent(globalLoginView);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
//    [self setupRightButton];
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

- (void)setViewRectEdge
{
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
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

- (void)getPopoverClickType:(NSUInteger) type
{
    [popoverController dismissPopoverAnimated:NO];
    [self showTips:[NSString stringWithFormat:@"选择了:%ld", type]];
    
    if (type == kOptionCtrlTypePopoverScan) {

        QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
        reader.title = @"扫一扫";
        reader.modalPresentationStyle = UIModalPresentationFormSheet;
        reader.delegate = self;
        
        __weak typeof (self) wSelf = self;
        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            [wSelf.navigationController popViewControllerAnimated:YES];
            [[[UIAlertView alloc] initWithTitle:@"" message:resultAsString delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
        }];
        
        //[self presentViewController:reader animated:YES completion:NULL];
        [self.navigationController pushViewController:reader animated:YES];
        
    }else if(type == kOptionCtrlTypePopoverVideo){
        
       
//        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }else if (type == kOptionCtrlTypePopoverFriend){
        
        ContactsViewController *contactsCtrl = [[ContactsViewController alloc] init];
        contactsCtrl.title = @"新朋友";
        contactsCtrl.notPopover = YES;
        contactsCtrl.notHeader = YES;
        contactsCtrl.hasInvitation = YES;
        contactsCtrl.notSelection = YES;
        [self.navigationController pushViewController:contactsCtrl animated:YES];
    }
    
    
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSLog(@"start of showImagePickerForSourceType");
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = (id)self;
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    
    NSLog(@"end of showImagePickerForSourceType");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"1");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"2");
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

//- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
//{
//    NSLog(@"hel");
//    *value = 0;
//}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    
    [WebViewController showWebPageInViewCtrl:self withUrl:result withPostData:nil];
//    [self dismissViewControllerAnimated:YES completion:^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popViewControllerAnimated:YES];
}


//判断用户是否登录,已登录跳转到首页
- (void)mainViewWithAnimate :(BOOL)animated
{
    NSLog(@"mainViewWithAnimate");
    if ([[UserDataManager sharedUserDataManager] isLogin]) {
        NSLog(@"mainViewWithAnimate is login");
        DNATabBarController *tabBarCtrl = [[DNATabBarController alloc] init];
        tabBarCtrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:tabBarCtrl animated:animated completion:^{}];
    }else{
        NSLog(@"mainViewWithAnimate is not login");
    }
}

@end
