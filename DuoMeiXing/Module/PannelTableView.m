//
//  PannelTableView.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PannelTableView.h"

#import "ListCell.h"

@implementation PannelTableView
{
    NSMutableArray *tableData;
    NSMutableArray *tableCells;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        tableCells = [[NSMutableArray alloc] init];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        [self addSubview:_tableView];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setScrollsToTop:NO];
        

        _tableView.tableFooterView = [UIView new];;
        
        [self setupInsetsTableView:_tableView];
        
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        
    }
    return self;
}

- (void)sendWorksRequest
{
    RequestService *api = [RequestService videoMemberReqeustPostData:[RequstVideoMember requstVideoMemberWithMemberId:_memberId PageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

- (void)sendCommentsRequest
{
    RequestService *api = [RequestService videoCommentReqeustPostData:[RequstVideoComment requstVideoCommentWithVideoId:_videoId PageNo:1 withPageSize:10]];
    [self sendRequestWith:api];
}

//- (void)sendWorksRequest
//{
//    RequestService *api = [RequestService videoMemberReqeustPostData:[RequstVideoMember requstVideoMemberWithMemberId:_memberId PageNo:1 withPageSize:10]];
//    [self sendRequestWith:api];
//}

- (void)sendRequestWith:(RequestService *)api
{
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        
        NSLog(@"succeed");
        
        

        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        
        if (_pannelType == kDisplayPannelWorks) {
            ResponseVideo *responseData = [ResponseVideo objectWithKeyValues:[request responseJSONObject]];
            [resultArray setArray:responseData.result];
            
        }else if (_pannelType == kDisplayPannelReview || _pannelType == kDisplayPannelComments){
            ResponseVideoCommentResult *responseData = [ResponseVideoCommentResult objectWithKeyValues:[request responseJSONObject]];

            NSMutableArray *reviewArray = [[NSMutableArray alloc] init];
            
            NSMutableArray *commentArray = [[NSMutableArray alloc] init];
            
            for (ResponseVideoComment *comment in responseData.result) {
                if ([comment.type isEqualToString:commentTypeNormal]) {
                    [commentArray addObject:comment];
                }else{
                    [reviewArray addObject:comment];
                }
            }
            
            if (_pannelType == kDisplayPannelReview){
                resultArray = reviewArray;
            }else if(_pannelType == kDisplayPannelComments){
                resultArray = commentArray;
            }

        }
        
        [resultArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ListCell *cell=[[ListCell alloc]init];
            [tableCells addObject:cell];
        }];
        
        if (tableData != nil) {
            tableData = resultArray;
//            [tableData setArray:resultArray];
        }else{
            tableData = [NSMutableArray arrayWithArray:resultArray];
        }

        [self.tableView reloadData];
        
        
    } failure:^(YTKBaseRequest *request) {

        NSLog(@"failed");
        
        NSLog(@"%@", [[request responseJSONObject] objectForKey:@"code"]);
        
    }];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGRect tableViewFrame = [self.tableView frame];
    tableViewFrame.size.width = self.frame.size.width;
    tableViewFrame.size.height = self.frame.size.height;
    [self.tableView setFrame:tableViewFrame];
}

- (void)setTableScrollEnabled:(BOOL)enabled
{
    _tableView.scrollEnabled = enabled;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *listCell = [tableCells objectAtIndex:indexPath.row];
    listCell.cellListType = _cellType;
    listCell.cellData = [tableData objectAtIndex:indexPath.row];
    return (listCell.height < listCellHeight) ? listCellHeight : listCell.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"cellId";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    cell.cellListType = _cellType;
    
    cell.cellData = [tableData objectAtIndex:indexPath.row];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_cellType == kCellListVideo) {
        
        ResponseVideoResult * result = [tableData objectAtIndex:indexPath.row];
        
        [self.delegate getCellData:result];
        
    }
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"placeholder_instagram"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有数据";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
