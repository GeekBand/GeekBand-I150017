//
//  didLogLeftViewController.m
//  Calibri
//
//  Created by SeaHub on 15/8/29.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "didLogLeftViewController.h"
#import "MiniPaperViewController.h"
#import "MiniWorldViewController.h"
#import "MyYardViewController.h"
#import "AnnounceViewController.h"
#import "MySettingViewController.h"
#import "LeftSlideViewController.h"
#import "willLogLeftViewController.h"



@interface didLogLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign)NSInteger count;//计数器
@end

@implementation didLogLeftViewController

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
        cell.textLabel.text = @"退出登录";
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
        MiniWorldViewController *miniWorldViewController = [[MiniWorldViewController alloc] init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:miniWorldViewController
                                                            animated:NO];

    }else if(indexPath.row == 2){
        //我的院子页面 - 初始化VC - 收回抽屉 - PushVC
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MyYardViewController *myYardViewController = [[MyYardViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:myYardViewController
                                                            animated:NO];
    }else if(indexPath.row == 3){
        //通知页面 - 初始化VC - 收回抽屉 - PushVC
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AnnounceViewController *announceViewController = [[AnnounceViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:announceViewController
                                                            animated:NO];
    }else if(indexPath.row == 4){
        //设置页面 - 初始化VC - 收回抽屉 - PushVC
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MySettingViewController *mySettingViewController = [[MySettingViewController alloc]init];
        [tempAppDelegate.leftSlideViewController closeLeftView];
        [tempAppDelegate.rootNavigationController pushViewController:mySettingViewController
                                                            animated:NO];
    }else if(indexPath.row == 5){
        /*退出流程 ：弹出确认消息框 - 询问是否确认
         取消 - 不做任何动作
         确认 - 收回抽屉 -执行后台退出逻辑（未实现） - 弹出退出成功消息框*/
        UIAlertView *logoutAlert = [[UIAlertView alloc]initWithTitle:@"确定退出吗?"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定" ,nil];
        [logoutAlert show];
    }else{
        NSLog(@"Error");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}

//抽屉上半部分处理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 180)];
    //上半部分背景颜色
    view.backgroundColor = [UIColor clearColor];
    
    //上半部分头像按钮
    self.headPortrait = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headPortrait.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 180);
    self.headPortrait.bounds = CGRectMake(10, 10, 80, 80);
    [self.headPortrait addTarget:self action:@selector(headPortraitCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.headPortrait.layer setMasksToBounds:YES];
    [self.headPortrait.layer setCornerRadius:self.headPortrait.bounds.size.width * 0.5];
    [self.headPortrait.layer setBorderWidth:0.5];
    [self.headPortrait.layer setBorderColor:[UIColor greenColor].CGColor];
    NSLog(@"此时应读取后台userImage");
    [view addSubview:self.headPortrait];
    
    //初始化全局变量并设置默认值
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    appdelegate.userName = [[UILabel alloc]init];
    appdelegate.userName.text = @"handsome";
    //初始化上半部分label
    self.userName = [[UILabel alloc]init];
    self.userName.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 300);
    self.userName.textAlignment = NSTextAlignmentCenter;
    self.userName.text = appdelegate.userName.text;
    NSLog(@"此时应读取后台userName");
    [view addSubview:self.userName];
    
    //使用通知中心接收头像、名称的更改
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotif:) name:@"ReloadView" object:nil];

    
    return view;
}

//头像按钮
-(void)headPortraitCliked{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MyYardViewController *myYardViewController = [[MyYardViewController alloc]init];
    [tempAppDelegate.leftSlideViewController closeLeftView];
    [tempAppDelegate.rootNavigationController pushViewController:myYardViewController
                                                        animated:NO];
}

//退出消息框确认后执行的动作 - ifLogin = NO - 侧边栏更换
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UIAlertView *logoutSuccess = [[UIAlertView alloc]initWithTitle:@"成功退出"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
        [logoutSuccess show];
        
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSLog(@"此时后台应执行退出逻辑");
        [tempAppDelegate.leftSlideViewController closeLeftView];
        
        //抽屉将已登录状态改成未登陆状态
        tempAppDelegate.ifLogin = NO;
        MiniPaperViewController *mainViewController = [[MiniPaperViewController alloc] init];
        tempAppDelegate.rootNavigationController =[[UINavigationController alloc]init];
        [tempAppDelegate.rootNavigationController pushViewController:mainViewController animated:YES];
        willLogLeftViewController *leftVC = [[willLogLeftViewController alloc] init];
        tempAppDelegate.leftSlideViewController = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tempAppDelegate.rootNavigationController];
        tempAppDelegate.window.rootViewController = tempAppDelegate.leftSlideViewController;
    }
}

#pragma mark - Notification methos
//用于接受通知更换头像
-(void)receivedNotif:(NSNotification *)notification {
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    
    if (appdelegate.headImage) {
        [self.headPortrait setBackgroundImage:appdelegate.headImage forState:UIControlStateNormal];
    }
    if (appdelegate.userName.text) {
        self.userName.text = appdelegate.userName.text;
    }
}



@end


