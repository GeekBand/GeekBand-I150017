//
//  MySettingViewController.h
//  Calibri
//
//  Created by SeaHub on 15/8/29.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySettingViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UITextField* userNameTF;
@property (nonatomic,strong)UITextField* userYardNameTF;
@property (nonatomic)BOOL userSexIsMale;//YES - 男 | NO - 女

@end
