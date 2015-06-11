//
//  JSSHomeViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSHomeViewController.h"
#import "JSSDropDownMenu.h"
#import "JSSTitleMenuViewController.h"
#import "JSSOAuthAccount.h"
#import "JSSOAuthAccountTool.h"
#import "AFNetworking.h"

@interface JSSHomeViewController () <JSSDropDownMenuDelegate>

@end

@implementation JSSHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 导航条左边按钮
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"]];
    
    // 导航条右边按钮
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"]];
    
    // 自定义按钮代替导航条的标题视图
    [self setUpTitleButton];
    
    // 更新首页
    [self updateHomePage];
}

// 更新首页
- (void)updateHomePage
{
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:responseObject[@"name"] forState:UIControlStateNormal];
        
        // 更新导航条位置
        [self updateNavWithTitleButton:titleButton];
        
        [account setName:responseObject[@"name"]];
        [JSSOAuthAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

// 自定义按钮代替导航条的标题视图
- (void)setUpTitleButton
{
    UIButton *titleButton = [[UIButton alloc] init];
    [titleButton setWidth:200];
    [titleButton setHeight:30];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    NSString *name = account.name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    // 更新导航条位置
    [self updateNavWithTitleButton:titleButton];
    
    [self.navigationItem setTitleView:titleButton];
}

// 更新导航条内容位置
- (void)updateNavWithTitleButton:(UIButton *)titleButton
{
    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, titleW, 0, 0)];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, imageW)];
}

- (void)titleClick:(id)from
{
    JSSDropDownMenu *menu = [JSSDropDownMenu menu];
    
    [menu setDelegate:self];
    
    JSSTitleMenuViewController *controller = [[JSSTitleMenuViewController alloc] init];
    controller.view.height = 200;
    controller.view.width = 200;
    [menu setContentController:controller];
    
    [menu showFromView:from];
}

- (void)dropDownMenuDidDismiss:(JSSDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [titleButton setSelected:NO];
    // [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)dropDownMenuDidShow:(JSSDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [titleButton setSelected:YES];
    // [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}

- (void)friendsearch
{
    NSLog(@"friendsearch");
}

- (void)pop
{
    NSLog(@"pop");
}

@end
