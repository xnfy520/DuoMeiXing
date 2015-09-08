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
#import "ContactsCell.h"
#import "PinYinForObjc.h"
#import "PinyinHelper.h"

@interface ContactsViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>

@end

@implementation ContactsViewController

{
    UITableView *mainTableView;
    UISearchBar *searchBar;
    UISearchController *searchCtrl;
    
    NSMutableArray *baseData;
    
    NSMutableArray  *dataList;
    NSMutableArray  *searchList;
    
    NSMutableArray *srcArray;
    
    NSMutableArray *userArray;
    
    UILocalizedIndexedCollation *collation;
    
    NSMutableArray *sectionsArray;
    
    NSMutableArray *keys;
    NSMutableArray *values;
    
    NSMutableDictionary *firstDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.notPopover) {
        [self setupRightButton];
    }
    
    baseData = [[NSMutableArray alloc] init];
    
    [self setupMainTableView];
    
    keys = [[NSMutableArray alloc] init];
    
    values = [[NSMutableArray alloc] init];

    if (_listType == kOptionCtrlTypeFriendTeacher) {
        [self requestFriendTeacher];
    }else if(_listType == kOptionCtrlTypeMentorAll){
        [self requestMentorAll];
    }else if(_listType == kOptionCtrlTypeTeacherAll){
        [self requestTeacherAll];
    }else{
        [self requestFriendAll];
    }

}

- (void)requestFriendAll
{
    RequestService *api = [RequestService friendAllRequestPostData:[RequstFriendAll requstFriendAllWithPageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)requestFriendTeacher
{
    RequestService *api = [RequestService friendTeacherRequestPostData:[RequstFriendTeacher requstFriendTeacherWithPageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)requestTeacherAll
{
    RequestService *api = [RequestService teacherAllRequestPostData:[RequstTeacherAll requstTeacherAllWithPageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)requestMentorAll
{
    RequestService *api = [RequestService mentorAllRequestPostData:[RequstMentorAll requstMentorAllWithPageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)sendRequestWith:(RequestService *)api
{
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSLog(@"succeed");
        
        if (_listType == kOptionCtrlTypeTeacherAll  || _listType == kOptionCtrlTypeMentorAll) {
            
            ResponseMemberResult *responseData = [ResponseMemberResult objectWithKeyValues:[request responseJSONObject]];
            
            [baseData setArray:responseData.result];
            
        }else{
            ResponseFriendResult *responseData = [ResponseFriendResult objectWithKeyValues:[request responseJSONObject]];
            
            [baseData setArray:responseData.result];
        }
        
        
        [self disposeData];
        
        [mainTableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        
        [self hideHUB];
        
        NSLog(@"failed");
        
        NSLog(@"%@", [[request responseJSONObject] objectForKey:@"code"]);
        
        
    }];
}

- (void)disposeData
{
    firstDic = [[NSMutableDictionary alloc] init];
    
    if (self.notHeader == NO) {
        [firstDic setObject:@[@"新朋友",@"老师"] forKey:@""];
    }

    if ([baseData count]>0) {

        for (id friend in baseData) {
            
            NSString *pf;
            
            if (_listType == kOptionCtrlTypeTeacherAll  || _listType == kOptionCtrlTypeMentorAll) {
                pf = [PinYinForObjc chineseConvertToPinYinHeadFirst:[(ResponseMember *)friend nickname]];
            }else{
                pf = [PinYinForObjc chineseConvertToPinYinHeadFirst:[(ResponseFriend *)friend nickName]];
            }
            
            if ([[firstDic allKeys] containsObject:pf]) {
                NSMutableArray *tmpArr = [firstDic objectForKey:pf];
                [tmpArr addObject:friend];
                [firstDic setObject:tmpArr forKey:pf];
            }else{
                NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
                [tmpArr addObject:friend];
                [firstDic setObject:tmpArr forKey:pf];
            }
        }
    }
    
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];

    [keyArray addObjectsFromArray:[[firstDic allKeys]  sortedArrayUsingSelector:@selector(compare:)]];

    [keys setArray:keyArray];
    
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

    NSString *key = [keys objectAtIndex:section];
    return [[firstDic objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *flag=@"cellFlag";
    ContactsCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[ContactsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if ([keys count]>0) {
        NSString *key = [keys objectAtIndex:indexPath.section];
        if (_notHeader == NO) {
            
            
            if ([key isEqualToString:@""]) {
                
                NSString *title = [[firstDic objectForKey:key] objectAtIndex:indexPath.row];
                
                cell.textLabel.text = title;
                
                if ([title isEqualToString:@"新朋友"]) {
                    
                    cell.imageView.image = [UIImage imageNamed:@"home_friend_new"];
                    
                    cell.textLabel.textColor = [UIColor darkTextColor];
                    
                }else if([title isEqualToString:@"老师"]) {
                    
                    cell.imageView.image = [UIImage imageNamed:@"home_friend_teacher"];
                    
                    cell.textLabel.textColor = [UIColor darkTextColor];
                    
                }
                
            }else{
                
                if (_listType == kOptionCtrlTypeTeacherAll  || _listType == kOptionCtrlTypeMentorAll) {
                    ResponseMember *friend = [[firstDic objectForKey:key] objectAtIndex:indexPath.row];
                    cell.textLabel.text = friend.nickname;
                    [cell.imageView sd_setImageWithURL:friend.photoUrl];
                }else{
                    ResponseFriend *friend = [[firstDic objectForKey:key] objectAtIndex:indexPath.row];
                    cell.textLabel.text = friend.nickName;
                    [cell.imageView sd_setImageWithURL:friend.logoUrl];
                }
            }

        }else{
            if (_listType == kOptionCtrlTypeTeacherAll  || _listType == kOptionCtrlTypeMentorAll) {
                ResponseMember *friend = [[firstDic objectForKey:key] objectAtIndex:indexPath.row];
                cell.textLabel.text = friend.nickname;
                [cell.imageView sd_setImageWithURL:friend.photoUrl];
            }else{
                ResponseFriend *friend = [[firstDic objectForKey:key] objectAtIndex:indexPath.row];
                cell.textLabel.text = friend.nickName;
                [cell.imageView sd_setImageWithURL:friend.logoUrl];
            }
        }
    }

    if (self.hasInvitation) {
        cell.showInvitation = YES;
    }else{
        cell.showInvitation = NO;
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
        
        NSString *ctrl = [[firstDic objectForKey:key] objectAtIndex:indexPath.row];
        
        ContactsViewController *contactsCtrl = [[ContactsViewController alloc] init];
        if ([ctrl isEqualToString:@"老师"]) {
            contactsCtrl.title = @"老师";
            contactsCtrl.notPopover = YES;
            contactsCtrl.notHeader = YES;
            contactsCtrl.listType = kOptionCtrlTypeFriendTeacher;
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
        displayCtrl.pannelIndex = kDisplayPannelInformation;
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

@end
