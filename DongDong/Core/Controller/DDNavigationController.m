//
//  DDNavigationController.m
//  DongDong
//
//  Created by javalong on 16/7/27.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "DDNavigationController.h"

@interface DDNavigationController ()

@end

@implementation DDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
