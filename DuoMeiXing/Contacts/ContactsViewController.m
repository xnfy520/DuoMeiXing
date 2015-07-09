//
//  ContactsViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ContactsViewController.h"
#import "DNADef.h"
#import "Person.h"

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
    
    NSArray *keys;
    NSArray *values;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupMainTableView];
    
    keys = @[@"", @"A", @"B", @"C", @"D", @"E"];
    
    values = @[
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
               
               ];

//    [self configureSections];
}

- (void)setupMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTableView];
    [self setupInsetsTableView:mainTableView];
    
    if ([mainTableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        mainTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        mainTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        mainTableView.sectionIndexColor = [UIColor grayColor];
    }
    
    [self setupSearchController];
}
- (void)setupSearchController
{
    searchCtrl = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchCtrl.hidesNavigationBarDuringPresentation = NO;
    searchCtrl.searchResultsUpdater = self; //设置显示搜索结果的控制器
    searchCtrl.dimsBackgroundDuringPresentation = NO; //设置开始搜索时背景显示与否
    [searchCtrl.searchBar sizeToFit]; //设置searchBar位置自适应
    searchCtrl.searchBar.tintColor = [UIColor whiteColor];
    searchCtrl.searchBar.backgroundColor = [UIColor colorWithRed:0.592 green:1.000 blue:0.119 alpha:1.000];
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
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 15)];
    sectionHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (28-14)/2, screenWidth-10, 14)];
    sectionLabel.text = [keys objectAtIndex:section];
    [sectionHeader addSubview:sectionLabel];
    return sectionHeader;
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
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
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
    return index;
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
