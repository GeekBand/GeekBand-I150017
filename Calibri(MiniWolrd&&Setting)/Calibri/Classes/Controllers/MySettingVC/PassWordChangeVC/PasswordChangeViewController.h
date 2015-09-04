//
//  PasswordChangeViewController.h
//  Calibri
//
//  Created by SeaHub on 15/8/31.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordChangeViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)UITextField* userOriginLoginKeyTF;//用户的原始密码
@property(nonatomic,strong)UITextField* userNewLoginKeyTF;//用户首次输入的新密码
@property(nonatomic,strong)UITextField* userAdmitNewLoginKeyTF;//用户再次确定输入的新密码




@end
