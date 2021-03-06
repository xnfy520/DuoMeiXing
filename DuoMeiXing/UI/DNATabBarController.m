//
//  DNATabBarController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DNATabBarController.h"
#import "DNANavigationViewController.h"
#import "DNADef.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface DNATabBarController ()

@end

@implementation DNATabBarController

- (id)init
{
    addObs(globalLoginView, onLoginView);
    addObs(globalRegisterView, onRegisterView);
    addObs(globalMainView, onMainView);
    addObs(globalLoginAction, onLogin);
    addObs(globalLogoutAction, onLogout);
    return [super init];
}

- (void)dealloc
{
    removeObs(globalLoginView);
    removeObs(globalRegisterView);
    removeObs(globalMainView);
    removeObs(globalLoginAction);
    removeObs(globalLogoutAction);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    // 初始化所以子控制器
    [self setupChildViewControls];
    
    [self setTitleTextColor];
    
}

//设置tabbaritem 选中或未选中颜色
- (void)setTitleTextColor
{
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1], NSForegroundColorAttributeName,[UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:defaultTabBarTitleColor, NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateSelected];
}

- (void)setupChildViewControls
{

    MessageViewController *mainCtrl = [[MessageViewController alloc]init];
    [self addChildViewControl:mainCtrl title:@"哆每星" imageName:@"i100" selectedImageName:@"i101" selectedTag:0];
    self.main = mainCtrl;
    
    ContactsViewController *contactsCtrl = [[ContactsViewController alloc]init];
    [self addChildViewControl:contactsCtrl title:@"通讯录" imageName:@"i200" selectedImageName:@"i201" selectedTag:1];

    DiscoverViewController *discoverCtrl = [[DiscoverViewController alloc]init];
    [self addChildViewControl:discoverCtrl title:@"发现" imageName:@"i300" selectedImageName:@"i301" selectedTag:2];
    

    MineViewController *mineCtrl = [[MineViewController alloc]init];
    [self addChildViewControl:mineCtrl title:@"我" imageName:@"i400" selectedImageName:@"i401" selectedTag:3];
}

- (void)addChildViewControl:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName selectedTag:(NSInteger)tag
{
    // 设置标题图片
    childVc.title = title;
    childVc.tabBarItem.tag = tag;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childVc.tabBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor lightGrayColor], NSForegroundColorAttributeName,
      [UIFont systemFontOfSize:12], NSFontAttributeName,
      nil] forState:UIControlStateNormal];
    
    // 添加到导航控制器

    DNANavigationViewController *childVcNav = [DNATabBarController setCtrl:childVc];
    [self addChildViewController:childVcNav];
    
    //    //设置导航条颜色
    //    [childVcNav.navigationBar setBarTintColor:[UIColor colorWithRed:1 green:0.58 blue:0.3 alpha:1]];
    //
    //    childVcNav.navigationBar.tintColor = [UIColor whiteColor];
    //
    //    //设置导航条字体
    //    [childVcNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"ArialMT" size:18], NSFontAttributeName, nil]];
    
    // 添加自定义item
//    [self.customTabBar addButtonWithItem:childVc.tabBarItem];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}


+ (DNANavigationViewController *)setCtrl:(UIViewController *)ctrl
{
    DNANavigationViewController *childVcNav = [[DNANavigationViewController alloc]initWithRootViewController:ctrl];
    
    //设置导航条颜色
    
    [childVcNav.navigationBar setBarTintColor:defaultNavigationBar];
    
    childVcNav.navigationBar.tintColor = [UIColor whiteColor];
    
    //设置导航条字体
    [childVcNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"ArialMT" size:18], NSFontAttributeName, nil]];
    
    return childVcNav;
}

-(void)onLoginView:(NSNotification*) notification
{
    NSLog(@"onLoginView");
    
    [[NSUserDefaults standardUserDefaults] setObject:@"login" forKey:@"dismisstype"];
    
    [self dismissViewControllerAnimated:NO completion:^{
    
    }];
}


-(void)onRegisterView:(NSNotification*) notification
{
    NSLog(@"onRegisterView");
    
    [[NSUserDefaults standardUserDefaults] setObject:@"reg" forKey:@"dismisstype"];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
}

-(void)onMainView:(NSNotification*) notification
{
    NSLog(@"onMainView");
    
    [self presentViewController:[[DNATabBarController alloc] init] animated:NO completion:^{
    
    }];

}

- (void)onLogin:(NSNotification*) notification
{
    NSLog(@"onLogin");
    //执行登录操作 跳转到首页
    postEvent(globalMainView);
}

- (void)onLogout:(NSNotification*) notification
{
    NSLog(@"onLogout");
    //执行退出操作 清空本地数据库用户信息
    [[UserDataManager sharedUserDataManager] clearUser];
    //跳转到登录界面
    postEvent(globalLoginView)
}

@end
