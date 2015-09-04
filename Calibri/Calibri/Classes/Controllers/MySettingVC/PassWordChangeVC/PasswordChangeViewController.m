//
//  PasswordChangeViewController.m
//  Calibri
//
//  Created by SeaHub on 15/8/31.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "PasswordChangeViewController.h"
#import "AppDelegate.h"
#define KEYLENTH 8

@interface PasswordChangeViewController ()

@end

@implementation PasswordChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self constructMenuButton];
    [self constructOriginKeyView];
    [self constructChangeLoginKeyView];
    [self constructAdmitChangeLoginKeyView];
    [self constructSaveNewKeyButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Construct View
//初始化抽屉 - 左拉弹出菜单
-(void)constructMenuButton{
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

//初始化原始密码Label以及密码框 - self.userOriginKeyTF验证旧密码
-(void)constructOriginKeyView{
    UILabel* originKeyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.1, 70, 70)];
    originKeyLabel.text = @"原始密码";
    [self.view addSubview:originKeyLabel];
    
    self.userOriginLoginKeyTF = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1 + 100, self.view.frame.size.height * 0.1 + 23, self.view.frame.size.width - 150, 30)];
    self.userOriginLoginKeyTF.placeholder = @"请输入8位原始密码";
    [self.view addSubview:self.userOriginLoginKeyTF];
    
    self.userOriginLoginKeyTF.secureTextEntry = YES;
    self.userOriginLoginKeyTF.delegate = self;
    [self.userOriginLoginKeyTF addTarget:self
                                  action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
}

//初始化修改密码Label以及密码框 - self.userLoginKeyTF存储新密码
-(void)constructChangeLoginKeyView{
    UILabel* changeKeyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.2, 70, 70)];
    changeKeyLabel.text = @"新的密码";
    [self.view addSubview:changeKeyLabel];
    
    self.userNewLoginKeyTF = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1 + 100, self.view.frame.size.height * 0.2 + 23, self.view.frame.size.width - 150, 30)];
    self.userNewLoginKeyTF.placeholder = @"请输入8位新密码";
    [self.view addSubview:self.userNewLoginKeyTF];
    
    self.userNewLoginKeyTF.secureTextEntry = YES;
    self.userNewLoginKeyTF.delegate = self;
    [self.userNewLoginKeyTF addTarget:self
                               action:@selector(textFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
}

//初始化确认修改密码Label以及密码框 - self.userAdmitLoginKeyTF存储新密码
-(void)constructAdmitChangeLoginKeyView{
    UILabel* admitChangeKeyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.3, 90, 70)];
    admitChangeKeyLabel.text = @"确定新密码";
    [self.view addSubview:admitChangeKeyLabel];
    
    self.userAdmitNewLoginKeyTF = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1 + 100, self.view.frame.size.height * 0.3 + 23, self.view.frame.size.width - 150, 30)];
    self.userAdmitNewLoginKeyTF.placeholder = @"请再次输入新的密码";
    [self.view addSubview:self.userAdmitNewLoginKeyTF];
    
    self.userAdmitNewLoginKeyTF.secureTextEntry = YES;
    self.userAdmitNewLoginKeyTF.delegate = self;
    [self.userAdmitNewLoginKeyTF addTarget:self
                                    action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
}

//初始化保存修改按钮 - 点击保存密码修改到临时变量+本地（未实现） - 将新密码上传到后台（未实现）
-(void)constructSaveNewKeyButton{
    UIButton* saveNewKeyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.38, self.view.frame.size.height * 0.45, 80, 40)];
    [saveNewKeyButton setTitle:@"保存修改" forState:UIControlStateNormal];
    [saveNewKeyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    saveNewKeyButton.layer.borderWidth = 0.5;
    saveNewKeyButton.layer.cornerRadius = 10;
    saveNewKeyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [saveNewKeyButton addTarget:self
                         action:@selector(saveNewKeyButtonCliked)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveNewKeyButton];
}

#pragma mark - ButtonAction
//侧边栏按钮动作
-(void)menuRun{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([tempAppDelegate.leftSlideViewController closed]) {
        [tempAppDelegate.leftSlideViewController openLeftView];
    }else{
        [tempAppDelegate.leftSlideViewController closeLeftView];
    }
}

//保存按钮动作 - 验证旧密码 - 验证新密码是否相等(限制了密码长度(KEYLENTH)为8，大小写不同的字符串为不同的密码)
//修改全局变量值（未实现） - 写入本地缓存（未实现） - 将新密码上传到后台（未实现）
-(void)saveNewKeyButtonCliked{
    if(self.userOriginLoginKeyTF.text.length != KEYLENTH)//此处可加上与后台密码不一致的情况
    {
        UIAlertView* error = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"原始密码错误，原始密码少于8位或原始密码错误"
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [error show];

    }
    else if(self.userNewLoginKeyTF.text.length != KEYLENTH)
    {
        UIAlertView* error = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"新密码设置错误，新密码少于8位"
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [error show];
        
    }
    else if(self.userAdmitNewLoginKeyTF.text.length != KEYLENTH
            || !([self.userNewLoginKeyTF.text isEqualToString:self.userAdmitNewLoginKeyTF.text]))
    {
        UIAlertView* error = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"新密码设置错误，两次输入的新密码不一致"
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [error show];
    }else {
        NSLog(@"此时应上传新密码到后台");
        UIAlertView* success = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"新密码设置成功"
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
        [success show];
        //保存数据到临时变量
    }

}


#pragma mark - keyboardRelated
//限制新密码为8位数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > KEYLENTH) {
        textField.text = [textField.text substringToIndex:KEYLENTH];
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





@end
