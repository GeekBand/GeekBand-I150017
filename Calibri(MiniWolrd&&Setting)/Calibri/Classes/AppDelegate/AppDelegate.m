//
//  AppDelegate.m
//  Calibri
//
//  Created by SeaHub on 15/8/29.
//  Copyright (c) 2015年 CalibriDevelop. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Window初始化
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //主页面 微刊 初始化
    MiniPaperViewController *mainViewController = [[MiniPaperViewController alloc] init];
    self.rootNavigationController =[[UINavigationController alloc]
                                    initWithRootViewController:mainViewController];
    
    
    //顶部导航栏颜色设置
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    //判断是否登陆(默认NO) - 并根据不同状态读取不同侧边栏
    self.ifLogin = YES;
    if (self.ifLogin) {
        didLogLeftViewController *leftVC = [[didLogLeftViewController alloc] init];
        self.leftSlideViewController = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.rootNavigationController];
        self.window.rootViewController = self.leftSlideViewController;
    }else{
        willLogLeftViewController *leftVC = [[willLogLeftViewController alloc] init];
        self.leftSlideViewController = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.rootNavigationController];
        self.window.rootViewController = self.leftSlideViewController;
    }
    
    [self constructZanNumberRandomly];
    [self constructIfZanArray:self.zanNumberArray];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
}

-(void)constructZanNumberRandomly{
    NSInteger temp;
    self.zanNumberArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<10; ++i) {
        temp = arc4random() % 400;
        NSNumber *tempNumber = [NSNumber numberWithInteger:temp];
        [self.zanNumberArray addObject:tempNumber];
    }
    
}

-(void)constructIfZanArray:(NSMutableArray *)cellArray{
    NSString *ifZan = @"NO";
    self.ifZanArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<[cellArray count]; ++i) {
        [self.ifZanArray addObject:ifZan];
    }
    
}

@end
