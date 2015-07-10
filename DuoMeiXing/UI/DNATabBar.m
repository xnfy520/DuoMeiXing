//
//  DNATabBar.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/6/18.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "DNATabBar.h"
#import "DNATabBarButton.h"

@interface DNATabBar()
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, strong) NSMutableArray *arrButton;
@end

@implementation DNATabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    }
    return self;
}


- (NSMutableArray *)arrButton
{
    if (_arrButton == nil) {
        _arrButton = [NSMutableArray array];
    }
    return _arrButton;
}

- (void)addButtonWithItem:(UITabBarItem *)item
{
    NSLog(@"hello");
    // 创建按钮
    DNATabBarButton *button = [[DNATabBarButton alloc]init];
    [self addSubview:button];
    [self.arrButton addObject:button];
    
    button.item = item;
    // 点击监听
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    if (self.arrButton.count == 1) {
        [self clickButton:button];
    }
}

- (void)clickButton:(UIButton *)button
{
    // 通知代理点击了哪个
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonfrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonfrom:self.selectButton.tag to:button.tag];
    }
    // 点击按钮状态改变
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}

// 子视图布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    for (int index = 0; index<self.arrButton.count; index++) {
        // 1.取出按钮
        DNATabBarButton *button = self.arrButton[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}


@end
