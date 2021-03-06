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
#import "JSSEmotionTool.h"

@interface JSSEmotionKeyboard () <JSSEmotionTabBarViewDelegate>

@property (nonatomic, weak) JSSEmotionTabBarView *tabBarView;
@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, strong) JSSEmotionListView *recentListView;
@property (nonatomic, strong) JSSEmotionListView *defaultListView;
@property (nonatomic, strong) JSSEmotionListView *emojiListView;
@property (nonatomic, strong) JSSEmotionListView *flowerListView;

@end

@implementation JSSEmotionKeyboard

- (JSSEmotionListView *)recentListView
{
    if (_recentListView == nil) {
        _recentListView = [[JSSEmotionListView alloc] init];
    }
    return _recentListView;
}

- (JSSEmotionListView *)defaultListView
{
    if (_defaultListView == nil) {
        _defaultListView = [[JSSEmotionListView alloc] init];
        _defaultListView.emotions = [JSSEmotionTool defaultEmotions];
    }
    return _defaultListView;
}

- (JSSEmotionListView *)emojiListView
{
    if (_emojiListView == nil) {
        _emojiListView = [[JSSEmotionListView alloc] init];
        _emojiListView.emotions = [JSSEmotionTool emojiEmotions];
    }
    return _emojiListView;
}

- (JSSEmotionListView *)flowerListView
{
    if (_flowerListView == nil) {
        _flowerListView = [[JSSEmotionListView alloc] init];
        _flowerListView.emotions = [JSSEmotionTool flowerEmotions];
    }
    return _flowerListView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容视图
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        // 表情选项卡
        JSSEmotionTabBarView *tabBarView = [[JSSEmotionTabBarView alloc] init];
        [tabBarView setDelegate:self];
        [self addSubview:tabBarView];
        self.tabBarView = tabBarView;
        
        // 键盘接收表情选中的通知
        [JSSNotificationCenter addObserver:self selector:@selector(emotionDidSelected) name:JSSEmotionDidSelected object:nil];
    }
    return self;
}

/**
 *  表情按钮监听方法
 */
- (void)emotionDidSelected
{
    [self.recentListView setEmotions:[JSSEmotionTool emotions]];
}

/**
 *  移除通知
 */
- (void)dealloc
{
    [JSSNotificationCenter removeObserver:self];
}

/**
 *  表情选项卡的代理方法
 */
- (void)emotionTabBarView:(JSSEmotionTabBarView *)emotionTabBarView emotionTabBarViewButtonType:(emotionTabBarViewButtonType)emotionTabBarViewButtonType
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (emotionTabBarViewButtonType) {
        case emotionTabBarViewButtonLatest:
            [self.contentView addSubview:self.recentListView];
            [_recentListView setEmotions:[JSSEmotionTool emotions]];
            break;
            
        case emotionTabBarViewButtonDefault:
            [self.contentView addSubview:self.defaultListView];
            break;
            
        case emotionTabBarViewButtonEmoji:
            [self.contentView addSubview:self.emojiListView];
            break;
            
        case emotionTabBarViewButtonFlower:
            [self.contentView addSubview:self.flowerListView];
            break;
    }
    
    /**
     *  调用layoutSubviews进行子控件的重新布局
     */
    [self setNeedsLayout];
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat tabBarHeight = 37;
    
    [self.contentView setX:0];
    [self.contentView setY:0];
    [self.contentView setWidth:self.width];
    [self.contentView setHeight:self.height - tabBarHeight];
    
    [self.tabBarView setX:0];
    [self.tabBarView setY:self.contentView.height];
    [self.tabBarView setWidth:self.width];
    [self.tabBarView setHeight:tabBarHeight];
    
    JSSEmotionListView *listView = [self.contentView.subviews lastObject];
    [listView setFrame:self.contentView.frame];
}

@end
