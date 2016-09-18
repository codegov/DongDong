//
//  CreateStretchChatViewController.m
//  DongDong
//
//  Created by javalong on 16/7/27.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "SelectedStretchChatViewController.h"
#import "StretchChat.h"
#import "EditStretchChatController.h"

@interface SelectedStretchChatViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) StretchChat *chat;

@end

@implementation SelectedStretchChatViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"选择运动";
        _dataArray = [[NSMutableArray alloc] init];
        _chat = [StretchChat MR_createEntity];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.URL = [NSURL URLWithString:@"https://s-media-cache-ak0.pinimg.com/originals/07/44/38/074438e7c75034df2dcf37ba1057803e.gif"];
    imageNode.frame = self.view.bounds;
    imageNode.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageNode.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubnode:imageNode];

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRightAction)];
    self.navigationItem.rightBarButtonItem = right;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"custrom" forKey:@"type"];
    [dic setObject:@"first"   forKey:@"icon"];
    [dic setObject:@"first"   forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"骑行" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"爬楼梯" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"健身" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"日常活动" forKey:@"title"];
    [_dataArray addObject:dic];
    
    
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"骑行" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"爬楼梯" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"健身" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"日常活动" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"骑行" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"爬楼梯" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"健身" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"日常活动" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"骑行" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"爬楼梯" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"健身" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"日常活动" forKey:@"title"];
    [_dataArray addObject:dic];
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"骑行" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"爬楼梯" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"健身" forKey:@"title"];
    [_dataArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"first" forKey:@"icon"];
    [dic setObject:@"日常活动" forKey:@"title"];
    [_dataArray addObject:dic];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightAction
{
    EditStretchChatController *edit = [[EditStretchChatController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
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
    static NSString *tempID = @"CreateStretchChat";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tempID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tempID];
    }
    NSDictionary  *dic = [_dataArray objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    cell.imageView.image = image;
    cell.textLabel.text = [dic objectForKey:@"title"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
