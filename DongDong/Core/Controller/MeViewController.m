//
//  MeViewController.m
//  DongDong
//
//  Created by javalong on 16/7/26.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "MeViewController.h"

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tempID = @"Me";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tempID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tempID];
    }
    
    cell.detailTextLabel.text = @(indexPath.row).stringValue;
    cell.textLabel.text = @"日常运动";
    
    return cell;
}

@end
