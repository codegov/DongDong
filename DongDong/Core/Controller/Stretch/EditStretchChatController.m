//
//  EditStretchChatController.m
//  DongDong
//
//  Created by javalong on 16/7/27.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "EditStretchChatController.h"
#import "DDTextField.h"
#import "DDLabel.h"

@interface EditStretchChatController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation EditStretchChatController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"新增运动";
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)receiveUITextFieldTextDidChangeNotification
{
//    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUITextFieldTextDidChangeNotification) name:UITextFieldTextDidChangeNotification object:nil];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"header" forKey:@"type"];
    [dic setObject:@"图标" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"name" forKey:@"type"];
    [dic setObject:@"名称" forKey:@"title"];
    [_dataArray addObject:dic];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tempID = @"EditStretchChat";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tempID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tempID];
    }
    NSDictionary  *dic = [_dataArray objectAtIndex:indexPath.row];
//    cell.textLabel.text = [dic objectForKey:@"title"];
    
    DDLabel *textField =  [cell.contentView viewWithTag:99];
    if (!textField) {
        textField = [[DDLabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width - 30, 50)];
        [cell.contentView addSubview:textField];
    }
    
    textField.text = [NSString stringWithFormat:@"%@-------%@",[dic objectForKey:@"title"] , @(indexPath.row)];
    textField.tag = 99;
    textField.font = [UIFont systemFontOfSize:40];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary  *dic = [_dataArray objectAtIndex:indexPath.row];
    NSString *type = [dic objectForKey:@"type"];
    if ([type isEqualToString:@"header"])
    {
        
    } else if ([type isEqualToString:@"name"])
    {
        
    }
}

@end
