//
//  AppDelegate.h
//  DongDong
//
//  Created by javalong on 16/7/26.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) void (^backgroundSessionCompletionHandler)();
@property (nonatomic, strong) AFURLSessionManager *manager;

@end

