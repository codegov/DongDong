//
//  Test.swift
//  DongDong
//
//  Created by javalong on 16/8/24.
//  Copyright © 2016年 javalong. All rights reserved.
//

import Foundation

public class TestViewController: UIViewController
{
    
    public override func viewDidLoad()
    {
        super.viewDidLoad();
        self.title = "Swift 测试";
        self.view.backgroundColor = UIColor.blueColor();
        
        var button = UIButton();
        button.addTarget(self, action: #selector(TestViewController.doAction), forControlEvents: UIControlEvents.TouchUpInside);
        button.setTitle("Open", forState: UIControlState.Normal);
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.whiteColor().CGColor;
        button.layer.cornerRadius = 6;
        self.view.addSubview(button);
        
        button.mas_makeConstraints { make in
            make.centerX.mas_equalTo()(self.view.mas_centerX);
            make.top.mas_equalTo()(100);
            make.width.mas_equalTo()(80);
            make.height.mas_equalTo()(80);
        };
        
        button = UIButton();
        button.addTarget(self, action: #selector(TestViewController.doAction), forControlEvents: UIControlEvents.TouchUpInside);
        button.setTitle("Open2", forState: UIControlState.Normal);
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.whiteColor().CGColor;
        button.layer.cornerRadius = 6;
        self.view.addSubview(button);
        
        button.mas_makeConstraints { make in
            make.centerX.mas_equalTo()(self.view.mas_centerX);
            make.top.mas_equalTo()(200);
            make.width.mas_equalTo()(80);
            make.height.mas_equalTo()(80);
        };
    }
    
    internal func doAction()
    {
        let stre = SelectedStretchChatViewController();
        self.navigationController?.pushViewController(stre, animated: true);
    }
}