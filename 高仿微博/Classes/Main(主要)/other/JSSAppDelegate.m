//
//  JSSAppDelegate.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSAppDelegate.h"
#import "JSSOAuthViewController.h"
#import "JSSOAuthAccount.h"
#import "JSSOAuthAccountTool.h"
#import "UIWindow+Extension.h"

@implementation JSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.实例化window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2.设置窗口可见
    [self.window makeKeyAndVisible];

    // 3.设置根控制器
    // 获取账号信息
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    
    if (account) {
        // 切换控制器
        [UIWindow switchController];
    } else {
        [self.window setRootViewController:[[JSSOAuthViewController alloc] init]];
    }
    
    return YES;
}

@end
