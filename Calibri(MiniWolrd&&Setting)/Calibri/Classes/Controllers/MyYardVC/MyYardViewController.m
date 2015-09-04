//
//  MyYardViewController.m
//  Calibri
//
//  Created by SeaHub on 15/8/29.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "MyYardViewController.h"
#import "AppDelegate.h"
@interface MyYardViewController ()

@end

@implementation MyYardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的院子";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //侧边栏按钮设置
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.bounds = CGRectMake(0, 0, 20, 18);
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu"]
                          forState:UIControlStateNormal];
    [menuButton addTarget:self
                   action:@selector(menuRun)
         forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithCustomView:menuButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//侧边栏按钮动作
-(void)menuRun{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([tempAppDelegate.leftSlideViewController closed]) {
        [tempAppDelegate.leftSlideViewController openLeftView];
    }else{
        [tempAppDelegate.leftSlideViewController closeLeftView];
    }
}

@end
