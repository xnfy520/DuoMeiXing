//
//  ContactsViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ContactsViewController.h"
#import "DNADef.h"
#import "DisplayViewController.h"
#import "Person.h"
#import "ContactsCell.h"

@interface ContactsViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>

@end

@implementation ContactsViewController

{
    UITableView *mainTableView;
    UISearchBar *searchBar;
    UISearchController *searchCtrl;
    NSMutableArray  *dataList;
    NSMutableArray  *searchList;
    
    NSMutableArray *srcArray;
    
    NSMutableArray *userArray;
    
    UILocalizedIndexedCollation *collation;
    
    NSMutableArray *sectionsArray;
    
    NSMutableArray *keys;
    NSMutableArray *values;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.notPopover) {
        [self setupRightButton];
    }
    
    [self setupMainTableView];
    
    keys = [[NSMutableArray alloc] init];
    
    values = [[NSMutableArray alloc] init];
    
    [keys addObjectsFromArray:@[@"", @"A", @"B", @"C", @"D", @"E"]];
    
    [values addObjectsFromArray: @[
               @[
                   @"新朋友",
                   @"老师"
                   ],
               @[
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay",
                   @"alipay"
                   ],
               @[
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady",
                   @"bady"
                   ],
               @[
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay",
                   @"cosplay"
                   ],
               @[
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display",
                   @"display"
                   ],
               @[
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial",
                   @"emial"
                   ]
               
               ]];
    
    if (self.notHeader) {
        [keys removeObjectAtIndex:0];
        [values removeObjectAtIndex:0];
    }

}

- (void)setupMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTableView];
    [self setupInsetsTableView:mainTableView];

    
    //索引栏颜色
    if ([mainTableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        mainTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        mainTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        mainTableView.sectionIndexColor = [UIColor grayColor];
    }
    
//    [self setupSearchController];
}
- (void)setupSearchController
{
    searchCtrl = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchCtrl.hidesNavigationBarDuringPresentation = NO;
    searchCtrl.searchResultsUpdater = self; //设置显示搜索结果的控制器
    searchCtrl.dimsBackgroundDuringPresentation = NO; //设置开始搜索时背景显示与否
    [searchCtrl.searchBar sizeToFit]; //设置searchBar位置自适应
    searchCtrl.searchBar.placeholder = @"搜索";
    searchCtrl.searchBar.delegate = self;
    searchCtrl.searchBar.showsBookmarkButton = NO;
    searchCtrl.searchBar.showsScopeBar = NO;
    searchCtrl.searchBar.showsSearchResultsButton = NO;
    searchCtrl.searchBar.showsCancelButton = NO;
//    mainTableView.tableHeaderView = searchCtrl.searchBar;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {

        [cell setSeparatorInset:UIEdgeInsetsZero];

    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {

        [cell setLayoutMargins:UIEdgeInsetsZero];

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (20-14)/2, screenWidth-10, 14)];
    sectionLabel.text = [keys objectAtIndex:section];
    sectionLabel.textColor = [UIColor grayColor];
    sectionLabel.font = [UIFont systemFontOfSize:14];
    [sectionHeader addSubview:sectionLabel];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [keys objectAtIndex:section];
    if ([sectionTitle isEqualToString:@""]) {
        return 0;
    }else{
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return listCellHeight;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[values objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *flag=@"cellFlag";
    ContactsCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[ContactsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    
    NSString *title = [[values objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = title;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if ([title isEqualToString:@"新朋友"]) {
        
        cell.imageView.image = [UIImage imageNamed:@"home_friend_new"];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
        
    }else if([title isEqualToString:@"老师"]) {
        
        cell.imageView.image = [UIImage imageNamed:@"home_friend_teacher"];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
        
    }else{
        
        cell.imageView.image = [UIImage imageNamed:@"limbo"];
        
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
    }
    
    
    NSString *key = [keys objectAtIndex:indexPath.section];

    if ([key isEqualToString:@""]) {
        cell.showInvitation = NO;
    }else{
        if (self.hasInvitation) {
            cell.showInvitation = YES;
//            cell.alreadyInvitation = YES;
        }else{
            cell.showInvitation = NO;
        }
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    return [keys objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return keys;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index==0)
    {
        //index是索引条的序号。从0开始，所以第0 个是放大镜。如果是放大镜坐标就移动到搜索框处
//        [tableView scrollRectToVisible:searchCtrl.searchBar.frame animated:NO];
        return 0;
    }else{
        //因为返回的值是section的值。所以减1就是与section对应的值了
        return index;
    }
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = [searchCtrl.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (searchList!= nil) {
        [searchList removeAllObjects];
    }
    //过滤数据
    searchList= [NSMutableArray arrayWithArray:[dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [mainTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_notSelection) {
        return;
    }
    
    NSString *key = [keys objectAtIndex:indexPath.section];
    
    if ([key isEqualToString:@""]) {
        NSString *ctrl = [[values objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSLog(@"%@", ctrl);
        ContactsViewController *contactsCtrl = [[ContactsViewController alloc] init];
        if ([ctrl isEqualToString:@"老师"]) {
            contactsCtrl.title = @"老师";
            contactsCtrl.notPopover = YES;
            contactsCtrl.notHeader = YES;
        }else if([ctrl isEqualToString:@"新朋友"]){
            contactsCtrl.title = @"新朋友";
            contactsCtrl.notPopover = YES;
            contactsCtrl.notHeader = YES;
            contactsCtrl.hasInvitation = YES;
            contactsCtrl.notSelection = YES;
        }
        [self.navigationController pushViewController:contactsCtrl animated:YES];
    }else{
        DisplayViewController *displayCtrl = [[DisplayViewController alloc] init];
        displayCtrl.haveViedo = NO;
        [self.navigationController pushViewController:displayCtrl animated:YES];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索End");
    return YES;
}

#pragma mark -------配置分组信息------
#define NEW_USER(str) [[Person alloc] init:str name:str]

- (void)configureSections {
    
    //初始化测试数据
    userArray = [[NSMutableArray alloc] init];
    [userArray addObject:NEW_USER(@"")];
    [userArray addObject:NEW_USER(@"")];
    [userArray addObject:NEW_USER(@"test001")];
    [userArray addObject:NEW_USER(@"test002")];
    [userArray addObject:NEW_USER(@"test003")];
    [userArray addObject:NEW_USER(@"test004")];
    [userArray addObject:NEW_USER(@"test005")];
    
    [userArray addObject:NEW_USER(@"adam01")];
    [userArray addObject:NEW_USER(@"adam02")];
    [userArray addObject:NEW_USER(@"adam03")];
    
    [userArray addObject:NEW_USER(@"bobm01")];
    [userArray addObject:NEW_USER(@"bobm02")];
    
    [userArray addObject:NEW_USER(@"what01")];
    [userArray addObject:NEW_USER(@"0what02")];
    
    [userArray addObject:NEW_USER(@"李一")];
    [userArray addObject:NEW_USER(@"李二")];
    
    [userArray addObject:NEW_USER(@"胡一")];
    [userArray addObject:NEW_USER(@"胡二")];
    
    //获得当前UILocalizedIndexedCollation对象并且引用赋给collation,A-Z的数据
    collation = [UILocalizedIndexedCollation currentCollation];
    //获得索引数和section标题数
    NSInteger index, sectionTitlesCount = [[collation sectionTitles] count];
    NSLog(@"%ld---", (long)sectionTitlesCount);
    //临时数据，存放section对应的userObjs数组数据
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //设置sections数组初始化：元素包含userObjs数据的空数据
    for (index = 0; index < sectionTitlesCount+1; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    NSLog(@"%ld===", newSectionsArray.count);
    //将用户数据进行分类，存储到对应的sesion数组中
    for (Person *userObj in userArray) {
        
        //根据timezone的localename，获得对应的的section number
        NSInteger sectionNumber = [collation sectionForObject:userObj collationStringSelector:@selector(username)];
        NSLog(@"%ld==>%@", (long)sectionNumber, userObj.name);
        //获得section的数组
        NSMutableArray *sectionUserObjs = [newSectionsArray objectAtIndex:sectionNumber];
        
        //添加内容到section中
        [sectionUserObjs addObject:userObj];
    }
    
    //排序，对每个已经分类的数组中的数据进行排序，如果仅仅只是分类的话可以不用这步
    for (index = 0; index < sectionTitlesCount; index++) {
        
        NSMutableArray *userObjsArrayForSection = [newSectionsArray objectAtIndex:index];

        //获得排序结果
        NSArray *sortedUserObjsArrayForSection = [collation sortedArrayFromArray:userObjsArrayForSection collationStringSelector:@selector(username)];
        
        //替换原来数组
        [newSectionsArray replaceObjectAtIndex:index withObject:sortedUserObjsArrayForSection];
        
    }
    
    
    sectionsArray = newSectionsArray;
    
    NSLog(@"%@", sectionsArray);
    
}

@end
