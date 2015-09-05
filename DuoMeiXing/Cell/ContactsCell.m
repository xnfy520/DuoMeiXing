//
//  ContactsCell.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/22.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "ContactsCell.h"
#import "DNADef.h"
#import "SubmitButton.h"

@implementation ContactsCell
{
    SubmitButton *invitationButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupInvitationButton];
    }
    return self;
}

- (void)setupInvitationButton
{
    invitationButton = [[SubmitButton alloc] initWithFrame:CGRectMake(screenWidth-50-15, (CGRectGetHeight(self.contentView.frame)-25)/2, 50, 30) withTitle:@"邀请" withBackgroundColor:defaultTabBarTitleColor];
    [invitationButton setTitle:@"已添加" forState:UIControlStateDisabled];
    [invitationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    invitationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:invitationButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    invitationButton.hidden = !_showInvitation;
    
    self.imageView.frame = CGRectMake(15, (CGRectGetHeight(self.contentView.frame)-30)/2, 30, 30);
    
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+15, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    
    if(_alreadyInvitation){
        [invitationButton setEnabled:NO];
        [invitationButton setBackgroundColor:[UIColor clearColor]];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected){
        invitationButton.backgroundColor = defaultTabBarTitleColor;
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted){
        invitationButton.backgroundColor = defaultTabBarTitleColor;
    }
}

@end
