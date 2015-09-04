//
//  willLogLeftViewController.m
//  Calibri
//
//  Created by SeaHub on 15/8/29.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "willLogLeftViewController.h"
#import "MiniPaperViewController.h"
#import "MiniWorldViewController.h"
#import "MyYardViewController.h"
#import "AnnounceViewController.h"
#import "MySettingViewController.h"
#import "UserLoginViewController.h"
#import "LeftSlideViewController.h"
#import "didLogLeftViewController.h"

@interface willLogLeftViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation willLogLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TableView初始化及设置
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

//Cell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"微刊";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"微世界";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"我的院子";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"通知";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"设置";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"登录";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //微刊页面 - 初始化VC - 收回抽屉 - PushVC
        [tableView deselectRowAtIndexPath:indexPath animated:YES];//颜色渐变设置
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MiniPaperViewController *miniPaperViewController = [[MiniPaperViewController alloc] init];
        [tempAppDelegate.leftSlideViewController closeLeftView];//收回抽屉
        [tempAppDelegate.rootNavigationController pushViewController:miniPaperViewController
                                                            animated:NO];
    }else if(indexPath.row == 1){
        //微世界页面 - 初始化VC - 收回抽屉 - PushVC
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MiniWorldViewController *miniWorldViewController = [[MiniWorldViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:miniWorldViewController
                                                            animated:NO];
    }else if(indexPath.row == 2){
        //我的院子页面（未登录状态） - 跳转到登陆页面 - 初始化VC - 收回抽屉 - PushVC - 提示登陆
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UserLoginViewController *userLoginViewController = [[UserLoginViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:userLoginViewController
                                                            animated:NO];
        UIAlertView *loginTip = [[UIAlertView alloc]initWithTitle:@"请登录"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
        [loginTip show];
        
    }else if(indexPath.row == 3){
        //通知页面（未登录状态） - 跳转到登陆页面 - 初始化VC - 收回抽屉 - PushVC - 提示登陆
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UserLoginViewController *userLoginViewController = [[UserLoginViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:userLoginViewController
                                                            animated:NO];
        UIAlertView *loginTip = [[UIAlertView alloc]initWithTitle:@"请登录"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
        [loginTip show];
        
    }else if(indexPath.row == 4){
        //设置页面（未登录状态） - 跳转到登陆页面 - 初始化VC - 收回抽屉 - PushVC - 提示登陆
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UserLoginViewController *userLoginViewController = [[UserLoginViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:userLoginViewController
                                                            animated:NO];
        UIAlertView *loginTip = [[UIAlertView alloc]initWithTitle:@"请登录"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
        [loginTip show];
        
    }else if(indexPath.row == 5){
        //登陆页面 - 跳转到登陆页面- 初始化VC - 收回抽屉 - PushVC
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UserLoginViewController *userLoginViewController = [[UserLoginViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:userLoginViewController
                                                            animated:NO];
        
    }else{
        NSLog(@"Error");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}

//抽屉上半部分处理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 180)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 314, 180)];
    //上半部分背景颜色
    view.backgroundColor = [UIColor clearColor];
    
    //上半部分头像按钮
    UIButton *headPortrait = [UIButton buttonWithType:UIButtonTypeCustom];
    headPortrait.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 180);
    headPortrait.bounds = CGRectMake(10, 10, 80, 80);
    [headPortrait addTarget:self action:@selector(headPortraitCliked) forControlEvents:UIControlEventTouchUpInside];
    [headPortrait.layer setMasksToBounds:YES];
    [headPortrait.layer setCornerRadius:headPortrait.bounds.size.width * 0.5];
    [headPortrait.layer setBorderWidth:5];
    [headPortrait.layer setBorderColor:[UIColor greenColor].CGColor];
    [view addSubview:headPortrait];
    
    //上半部分user名label
    UILabel *logTip = [[UILabel alloc]init];
    logTip.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 300);
    logTip.text = @"请登录";
    logTip.textAlignment = NSTextAlignmentCenter;
    [view addSubview:logTip];
    
    return view;
}

//头像按钮（未登录状态） - 跳转到登陆页面 - 提示登陆
-(void)headPortraitCliked{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserLoginViewController *userLoginViewController = [[UserLoginViewController alloc]init];
    [tempAppDelegate.leftSlideViewController closeLeftView];
    [tempAppDelegate.rootNavigationController pushViewController:userLoginViewController
                                                        animated:NO];
    
    UIAlertView *loginTip = [[UIAlertView alloc]initWithTitle:@"请登录"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
    [loginTip show];
}



@end


