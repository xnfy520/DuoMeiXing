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
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
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


- (void)sendRequest
{
    RequstVideoMember *requestData = [[RequstVideoMember alloc] init];
    requestData.pageNo = @"1";
    requestData.pageSize = @"10";
    requestData.memberId = _memberId;
    NSLog(@"%@", _memberId);
    RequestService *request = [[RequestService alloc] initReqeustUrl:appAPIVideoMember withPostData:requestData withResponseValidator:nil];
    
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        
        NSLog(@"succeed");

        ResponseVideo *responseData = [ResponseVideo objectWithKeyValues:[request responseJSONObject]];
        
        [tableData setArray:responseData.result];
        
        NSLog(@"%@", tableData);
        
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return listCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            NSLog(@"%ld", (long)self.cellType);
    
    static NSString *cellId = @"cellId";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    ResponseVideoResult * result = [tableData objectAtIndex:indexPath.row];

    
    NSLog(@"%@", result.name);

    cell.cellListType = _cellType;
    
    
    
    cell.cellImageView.image = [UIImage imageNamed:@"limbo"];
    
    if (cell.cellListType == kCellListVideo) {
        cell.cellImageView.image = [UIImage imageNamed:@"xianjian"];
    }

    cell.cellDateLabel.text = @"6月16日";
    
    cell.cellTitleLabel.text = result.name;
    
    cell.cellDetailLabel.text = result.desc;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
