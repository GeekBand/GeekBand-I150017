//
//  MiniWorldViewController.m
//  Calibri
//
//  Created by SeaHub on 15/9/4.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "MiniWorldViewController.h"
#import "Appdelegate.h"
#import "MiniWolrdTableViewCell.h"

@interface MiniWorldViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MiniWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微世界";
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self constructMenu];
    [self constructCamera];
//    [self constructZanNumberRandomly:self.zanNumberArray];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - construct


-(void)constructMenu{
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

-(void)constructCamera{
    //发帖按钮设置
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.bounds = CGRectMake(0, 0, 20, 18);
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"camera"]
                            forState:UIControlStateNormal];
    [cameraButton addTarget:self
                     action:@selector(cameraButtonCliked)
           forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithCustomView:cameraButton];
}

#pragma mark - ButtoonMethods

-(void)menuRun{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([tempAppDelegate.leftSlideViewController closed]) {
        [tempAppDelegate.leftSlideViewController openLeftView];
    }else{
        [tempAppDelegate.leftSlideViewController closeLeftView];
    }
}

-(void)cameraButtonCliked{
    NSLog(@"调用发帖");
}


#pragma mark - dataSourceDelegateMethods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    
    return [appdelegate.zanNumberArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    static  NSString  *identifier=@"CustomCell";
    MiniWolrdTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MiniWolrdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.indexPath = indexPath;
    }
    
    if (![[appdelegate.ifZanArray objectAtIndex:indexPath.row] isEqualToString:@"NO"]) {
        cell.zanButton.alpha = 1;
        UIImage *image = [UIImage imageNamed:@"get"];
        [cell.zanButton setBackgroundImage:image forState:UIControlStateNormal];
    }else{
        cell.zanButton.alpha = 0.2;
        UIImage *image = [UIImage imageNamed:@"unget"];
        [cell.zanButton setBackgroundImage:image forState:UIControlStateNormal];

    }
    
    NSNumber *tempNum = [[NSNumber alloc]init];
    tempNum = [appdelegate.zanNumberArray  objectAtIndex:indexPath.row];
    cell.zanNumberLabel.text = [NSString stringWithFormat:@"%@",tempNum];
    NSLog(@"此时应从后台读数据");
    return cell;
}

#pragma mark - tableViewDelagateMethods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}



@end
