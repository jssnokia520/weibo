//
//  JSSEmotionKeyboard.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/29.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionKeyboard.h"
#import "JSSEmotionListView.h"
#import "JSSEmotionTabBarView.h"

@interface JSSEmotionKeyboard () <JSSEmotionTabBarViewDelegate>


@property (nonatomic, weak) JSSEmotionListView *listView;
@property (nonatomic, weak) JSSEmotionTabBarView *tabBarView;

@end

@implementation JSSEmotionKeyboard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        JSSEmotionListView *listView = [[JSSEmotionListView alloc] init];
        [listView setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:listView];
        self.listView = listView;
        
        JSSEmotionTabBarView *tabBarView = [[JSSEmotionTabBarView alloc] init];
        [tabBarView setDelegate:self];
        [self addSubview:tabBarView];
        self.tabBarView = tabBarView;
    }
    return self;
}

/**
 *
 */
- (void)emotionTabBarView:(JSSEmotionTabBarView *)emotionTabBarView emotionTabBarViewButtonType:(emotionTabBarViewButtonType)emotionTabBarViewButtonType
{
    switch (emotionTabBarViewButtonType) {
        case emotionTabBarViewButtonLatest:
            NSLog(@"最近");
            break;
        case emotionTabBarViewButtonDefault:
            NSLog(@"默认");
            break;
        case emotionTabBarViewButtonEmoji:
            NSLog(@"Emoji");
            break;
        case emotionTabBarViewButtonFlower:
            NSLog(@"浪小花");
            break;
    }
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat tabBarHeight = 37;
    
    [self.listView setX:0];
    [self.listView setY:0];
    [self.listView setWidth:self.width];
    [self.listView setHeight:self.height - tabBarHeight];
    
    [self.tabBarView setX:0];
    [self.tabBarView setY:self.listView.height];
    [self.tabBarView setWidth:self.width];
    [self.tabBarView setHeight:tabBarHeight];
}

@end
