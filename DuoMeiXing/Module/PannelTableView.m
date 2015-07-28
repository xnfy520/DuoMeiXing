//
//  PannelTableView.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/17.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "PannelTableView.h"
#import "DNADef.h"
#import "ListCell.h"

@implementation PannelTableView

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
        
        [self setupInsetsTableView:_tableView];
    }
    return self;
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
    
    
    static NSString *cellId = @"cellId";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    cell.cellListType = kCellListComment;
    
    cell.cellImageView.image = [UIImage imageNamed:@"limbo"];
    
    if ([_identifier isEqualToString:@"video"]) {
        cell.cellListType = kCellListVideo;
        cell.cellImageView.image = [UIImage imageNamed:@"xianjian"];
    }

    cell.cellDateLabel.text = @"6月16日";
    
    cell.cellTitleLabel.text = @"天陨";
    
    cell.cellDetailLabel.text = @"雪念飞叶";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
