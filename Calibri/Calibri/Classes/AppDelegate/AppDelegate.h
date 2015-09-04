//
//  AppDelegate.h
//  Calibri
//
//  Created by SeaHub on 15/8/29.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "didLogLeftViewController.h"
#import "willLogLeftViewController.h"
#import "MiniPaperViewController.h"
#import "LeftSlideViewController.h"
#import "UserLoginViewController.h"
#import "MiniWorldViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController *leftSlideViewController;
@property (strong, nonatomic) UINavigationController *rootNavigationController;

//全局变量
@property (strong, nonatomic) UIImage* headImage;
@property (strong, nonatomic) UILabel* userName;
@property (nonatomic)BOOL ifLogin;    //判断是否登陆(默认NO) - 用于抽屉初始化并读取不同页面

@end

