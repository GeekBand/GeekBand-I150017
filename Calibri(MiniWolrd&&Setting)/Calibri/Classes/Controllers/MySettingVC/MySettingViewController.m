//
//  MySettingViewController.m
//  Calibri
//
//  Created by SeaHub on 15/8/29.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "MySettingViewController.h"
#import "AppDelegate.h"
#import "MyYardViewController.h"
#import "PasswordChangeViewController.h"
#define YARDNAMELENTH 10
#define USERNAMELENTH 8

@interface MySettingViewController ()
@property (nonatomic,strong)UIButton *sexMaleButton;
@property (nonatomic,strong)UIButton *sexFemaleButton;


@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化 - 本页面
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化 - 抽屉、头像、更改头像、更换院子背景按钮、昵称框、院子框、性别选择按钮、保存按钮、修改密码、退出按钮
    [self constructMenuButton];
    [self constructHeadPortrait];
    [self constructChangeHeadPortrait];
    [self constructChangeYardBackground];
    [self constructUserName];
    [self constructUserYardName];
    [self constructSex];
    [self constructSave];
    [self constructChangePassword];
    [self constructLogoutButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - Construct View
//初始化抽屉 - 左拉弹出菜单
-(void)constructMenuButton{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.bounds = CGRectMake(0, 0, 20, 18);
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuButton addTarget:self
                   action:@selector(menuRun)
         forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
}

//头像按钮 - 点击头像跳转到我的院子
-(void)constructHeadPortrait{
    UIButton *headPortraitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    headPortraitButton.backgroundColor = [UIColor clearColor];
    NSLog(@"此时应读取后台userImage");
    [headPortraitButton setBackgroundImage:appdelegate.headImage forState:UIControlStateNormal];
    headPortraitButton.frame = CGRectMake(32, 90, 40, 40);
    headPortraitButton.tag = 100;
    [headPortraitButton.layer setCornerRadius:4];
    headPortraitButton.layer.borderWidth = 0.5;
    headPortraitButton.layer.borderColor = [UIColor blackColor].CGColor;
    [headPortraitButton addTarget:self
                           action:@selector(headPortraitCliked)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headPortraitButton];
}

//更改头像按钮 - 点击调用系统相册
-(void)constructChangeHeadPortrait{
    UIButton *changeHeadPortraitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeHeadPortraitButton.frame = CGRectMake(self.view.size.width *0.3, 95, 80, 30);
    [changeHeadPortraitButton setTitle:@"更换头像" forState:UIControlStateNormal];
    [changeHeadPortraitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeHeadPortraitButton addTarget:self
                                 action:@selector(changeHeadPortraitButtonCliked)
                       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeHeadPortraitButton];
}

//更改院子背景按钮 - 点击调用系统相册
-(void)constructChangeYardBackground{
    UIButton *changeYardBackgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeYardBackgroundButton.frame = CGRectMake(self.view.size.width *0.6, 95, 110, 30);
    [changeYardBackgroundButton setTitle:@"更改院子背景" forState:UIControlStateNormal];
    [changeYardBackgroundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeYardBackgroundButton addTarget:self
                                   action:@selector(changeYardBackgroundButtonCliked)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeYardBackgroundButton];
}

//昵称label及文本框 - self.userNameTF存储写入内容
-(void)constructUserName{
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:
                              CGRectMake(35,150, self.view.frame.size.width-280, 40)];
    userNameLabel.text = @"昵称";
    [self.view addSubview:userNameLabel];
    
    AppDelegate *delegate =[UIApplication sharedApplication].delegate;
    self.userNameTF = [[UITextField alloc]initWithFrame:
                     CGRectMake(100,150, self.view.frame.size.width - 150, 40)];
    self.userNameTF.placeholder = delegate.userName.text;
    [self.view addSubview:self.userNameTF];
    self.userNameTF.delegate = self;
    [self.userNameTF addTarget:self
                        action:@selector(userNameTextFieldDidChange)
              forControlEvents:UIControlEventEditingChanged];
}

//院子label及文本框 - self.userYardNameTF存储写入内容
-(void)constructUserYardName{
    UILabel *userYardNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 200, self.view.frame.size.width - 280, 40)];
    userYardNameLabel.text = @"院子";
    [self.view addSubview:userYardNameLabel];
    
    self.userYardNameTF = [[UITextField alloc]initWithFrame:
                         CGRectMake(100, 200, self.view.frame.size.width - 150, 40)];
    self.userYardNameTF.placeholder = @"我的秘密花园";
    [self.view addSubview:self.userYardNameTF];
    self.userYardNameTF.delegate = self;
    [self.userYardNameTF addTarget:self
                            action:@selector(userYardNameTextFieldDidChange)
                  forControlEvents:UIControlEventEditingChanged];
}

//性别label及选择男，女按钮 - self.userSexIsMale判断男女，默认男（YES）
-(void)constructSex{
    UILabel *userSexLabel = [[UILabel alloc]initWithFrame:
                             CGRectMake(35, 250, self.view.frame.size.width - 280, 40)];
    userSexLabel.text = @"性别";
    [self.view addSubview:userSexLabel];
    
    self.sexMaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sexMaleButton.frame = CGRectMake(120, 255, 28, 28);
    [self.sexMaleButton setTitle:@"男" forState:UIControlStateNormal];
    [self.sexMaleButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    self.sexMaleButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.sexMaleButton.layer.borderWidth = 0.5;
    self.sexMaleButton.layer.cornerRadius = 14;
    [self.sexMaleButton addTarget:self
                           action:@selector(sexMaleButtonCliked)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sexMaleButton];
    
    self.sexFemaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sexFemaleButton.frame = CGRectMake(200, 255, 28, 28);
    [self.sexFemaleButton setTitle:@"女" forState:UIControlStateNormal];
    [self.sexFemaleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.sexFemaleButton.layer.borderColor = [UIColor clearColor].CGColor;
    self.sexFemaleButton.layer.borderWidth = 0.5;
    self.sexFemaleButton.layer.cornerRadius = 14;
    self.sexFemaleButton.alpha = 0.7;
    [self.sexFemaleButton addTarget:self
                      action:@selector(sexFemaleButtonCliked)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sexFemaleButton];
    
    self.userSexIsMale = YES;
}

//保存按钮
-(void)constructSave{
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(32, 330, 70, 20);
    [saveButton setTitle:@"保存更改" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton addTarget:self
                   action:@selector(saveButtonCliked)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

//更改密码按钮
-(void)constructChangePassword{
    UIButton *changePasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changePasswordButton.frame = CGRectMake(32, 370, 70, 20);
    [changePasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
    changePasswordButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [changePasswordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changePasswordButton addTarget:self
                             action:@selector(changePasswordButtonCliked)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePasswordButton];
}

//退出按钮
-(void)constructLogoutButton{
    UIButton *LogoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutButton.frame = CGRectMake(32, 410, 100, 20);
    [LogoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    LogoutButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [LogoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LogoutButton addTarget:self
                     action:@selector(logoutButtonCliked)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LogoutButton];
}

#pragma mark - ButtonAction
//侧边栏按钮动作 - 左拉拉出抽屉
-(void)menuRun{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([tempAppDelegate.leftSlideViewController closed]) {
        [tempAppDelegate.leftSlideViewController openLeftView];
    }else{
        [tempAppDelegate.leftSlideViewController closeLeftView];
    }
}

//头像按钮动作 - 点击跳转到 我的院子 页面
-(void)headPortraitCliked{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MyYardViewController *myYardViewController = [[MyYardViewController alloc]init];
    [tempAppDelegate.rootNavigationController pushViewController:myYardViewController
                                                        animated:YES];
}

//更换头像按钮动作 - 点击调用相册 - 更改头像背景（实现50%） - 后台上传头像（未实现）
-(void)changeHeadPortraitButtonCliked{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    if (imagePicker.sourceType) {
        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        NSLog(@"此时应上传更换好的头像");
    } else {
        NSLog(@"Error");
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
}

//更换院子背景按钮动作 - 点击调用相册 - 更改院子背景（未实现） - 后台上传院子背景（未实现）
-(void)changeYardBackgroundButtonCliked{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if (imagePicker.sourceType) {
        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        NSLog(@"更换院子背景");
        NSLog(@"此时应上传更换好的院子背景");
    } else {
        NSLog(@"Error");
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
}

//更改性别按钮 - 女→男（男高亮）- 设置self.userSexIsMale = YES;
-(void)sexMaleButtonCliked{
    self.sexFemaleButton.alpha = 0.7;
    self.sexFemaleButton.layer.borderColor = [UIColor clearColor].CGColor;
    [self.sexFemaleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.sexMaleButton.alpha = 1;
    self.sexMaleButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.sexMaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.userSexIsMale = YES;
}

//更改性别按钮 - 男→女（女高亮）- 设置self.userSexIsMale = NO;
-(void)sexFemaleButtonCliked{
    self.sexMaleButton.alpha = 0.7;
    self.sexMaleButton.layer.borderColor = [UIColor clearColor].CGColor;
    [self.sexMaleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.sexFemaleButton.alpha = 1;
    self.sexFemaleButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.sexFemaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.userSexIsMale = NO;
}

//保存按钮 - 上传userNameTF,userYardNameTF，userSexIsMale等信息到后台（未实现）- 出现保存成功提示
-(void)saveButtonCliked{
    if(!self.userNameTF.text.length || !self.userYardNameTF.text.length)//此处可加上与后台用户名相等的情况
    {
        UIAlertView* error = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"用户名与院子名均不能为空"
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [error show];
    }else{
        NSLog(@"此时后台应执行保存命令");
        AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
        appdelegate.userName.text = self.userNameTF.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
        UIAlertView *SaveSuccessTip = [[UIAlertView alloc]initWithTitle:@"保存成功"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
        [SaveSuccessTip show];
    }
}

//修改密码按钮 - 跳转到修改密码页面
-(void)changePasswordButtonCliked{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    PasswordChangeViewController *passwordChangeViewController = [[PasswordChangeViewController alloc]init];
    [tempAppDelegate.rootNavigationController pushViewController:passwordChangeViewController
                                                        animated:YES];
}

//退出当前账号按钮 - 执行以下退出流程
/*退出流程 ：弹出确认消息框 - 询问是否确认
 取消 - 不做任何动作
 确认 - 执行后台退出逻辑（未实现） - 返回主页 微刊 - 提示成功退出 */
-(void)logoutButtonCliked{
    UIAlertView *logoutAlert = [[UIAlertView alloc]initWithTitle:@"确定退出吗?"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定" ,nil];
    [logoutAlert show];
    
}

#pragma mark - Delegate
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
#pragma mark - keyboardRelated
//限制用户名最大长度为USERNAMELENTH（默认为8）
- (void)userNameTextFieldDidChange
{
    NSString* message = [[NSString alloc]initWithFormat:@"用户名最大长度为%d",USERNAMELENTH];
    if (self.userNameTF.text.length > USERNAMELENTH) {
        self.userNameTF.text = [self.userNameTF.text substringToIndex:USERNAMELENTH];
        UIAlertView* error = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [error show];
    }
}

//限制院子名最大长度为YARDNAMELENTH（默认为10）
- (void)userYardNameTextFieldDidChange
{
    NSString* message = [[NSString alloc]initWithFormat:@"院子名最大长度为%d",YARDNAMELENTH];
    if (self.userYardNameTF.text.length > YARDNAMELENTH) {
        self.userYardNameTF.text = [self.userYardNameTF.text substringToIndex:YARDNAMELENTH];
        UIAlertView* error = [[UIAlertView alloc]initWithTitle:@"提示"
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
        [error show];
    }
}

//点击背景关闭键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//点击return关闭键盘 - 代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - Photos Delegate
//将选中的图片作为头像 - 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //读取选中的图片
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //更改设置里的头像
    UIButton* headPortrit = (UIButton*)[self.view viewWithTag:100];
    [headPortrit setBackgroundImage:image forState:UIControlStateNormal];
    
    //更改抽屉里的头像
    AppDelegate* appdelegate = [UIApplication sharedApplication].delegate;
    appdelegate.headImage = image;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
    
    //关闭相册视图
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
