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
#import "AppDelegate.h"

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
    
    [self textRequest];
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

- (void)textRequest
{
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    NSDictionary *parameters = @{@"foo": @"bar"};
    //    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    //    [manager POST:@"http://example.com/resources.json" parameters:parameters constructingBodyWithBlock:^(id<</b>AFMultipartFormData> formData) {
    //        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"Success: %@", responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Error: %@", error);
    //    }];
    
    [self testDownload];
}

- (void)testDownload
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AFURLSessionManager *manager = appDelegate.manager;
    
    NSURL *URL = [NSURL URLWithString:@"http://p.qpic.cn/wenwenpic/0/20160920164650-1363656770/0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress==%@  %@", @(downloadProgress.totalUnitCount), @(downloadProgress.fractionCompleted));
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSLog(@"url==%@", documentsDirectoryURL);
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.alertBody = @"You have been Download!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDelegate.backgroundSessionCompletionHandler)
        {
            void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
            appDelegate.backgroundSessionCompletionHandler = nil;
            completionHandler();
        }
    }];
    [downloadTask resume];
}

- (void)testUpload
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    [manager invalidateSessionCancelingTasks:YES];
    
    NSURL *URL = [NSURL URLWithString:@"http://test.worldapi.wenwen.sogou.com/app/uploadpic"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:@"DongDong.entitlements"];
    NSURL *filePath = [NSURL fileURLWithPath:path];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}


@end
