//
//  FieldsEditViewController.m
//  DuoMeiXing
//
//  Created by 天陨 on 15/7/23.
//  Copyright (c) 2015年 wake. All rights reserved.
//

#import "FieldsEditViewController.h"
#import "DNADef.h"

#define EDIT_FIELD_TAG 1

@implementation FieldsEditViewController
{
    UITableView *mainTableView;
    UITextField *firstResponderField;
    UITextField *editField;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"昵称";
    
    [self setupMainTabelView];
    
    [self setupBarButtonItems];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [editField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [firstResponderField resignFirstResponder];
}

- (void)setupMainTabelView
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    [self.view addSubview:mainTableView];
    
    [self setupInsetsTableView:mainTableView];
}

- (void)setupBarButtonItems
{
    UIBarButtonItem *canelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canelAction)];
    self.navigationItem.leftBarButtonItem = canelItem;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    NSDictionary* titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor orangeColor]};
    [saveItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = saveItem;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        editField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, CGRectGetHeight(cell.frame))];
        editField.clearButtonMode = UITextFieldViewModeWhileEditing;
        editField.delegate = self;
        editField.tag = EDIT_FIELD_TAG;
        [cell.contentView addSubview:editField];
    }else{
        editField = (UITextField *)[cell.contentView viewWithTag:EDIT_FIELD_TAG];
    }
    editField.font = [UIFont systemFontOfSize:14];
    editField.text = [UserDataManager sharedUserDataManager].nickname;
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    firstResponderField = textField;
}

- (void)canelAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveAction
{

}

@end
