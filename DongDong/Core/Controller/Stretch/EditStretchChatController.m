//
//  EditStretchChatController.m
//  DongDong
//
//  Created by javalong on 16/7/27.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "EditStretchChatController.h"

@interface EditStretchChatController ()

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"header" forKey:@"type"];
    [dic setObject:@"图标" forKey:@"title"];
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
    cell.textLabel.text = [dic objectForKey:@"title"];
    
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
