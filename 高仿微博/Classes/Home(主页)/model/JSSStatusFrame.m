//
//  JSSStatusFrame.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/20.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusFrame.h"
#import "JSSStatus.h"
#import "JSSUser.h"
#import "JSSStatusPhotosView.h"

@implementation JSSStatusFrame

/**
 *  微博模型
 */
- (void)setStatus:(JSSStatus *)status
{
    _status = status;
    
    // 开始计算控件位置
    
    JSSUser *user = status.user;
    
    /**
     *  头像
     */
    CGFloat iconX = JSSStatusCellMargin;
    CGFloat iconY = JSSStatusCellMargin;
    CGFloat iconWH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /**
     *  昵称
     */
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + JSSStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name textSizeWithFont:JSSNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    /**
     *  VIP
     */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + JSSStatusCellMargin;
        CGFloat vipY = nameY;
        CGSize vipSize = CGSizeMake(self.nameFrame.size.height, self.nameFrame.size.height);
        self.vipFrame = (CGRect){{vipX, vipY}, vipSize};
    }
    
    /**
     *  时间
     */
    CGFloat timeX = CGRectGetMaxX(self.iconFrame) + JSSStatusCellMargin;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + JSSStatusCellMargin;
    CGSize timeSize = [status.created_at textSizeWithFont:JSSTimeFont];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    /**
     *  来源
     */
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + JSSStatusCellMargin;
    CGFloat sourceY = CGRectGetMaxY(self.nameFrame) + JSSStatusCellMargin;
    CGSize sourceSize = [status.source textSizeWithFont:JSSSourceFont];
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /**
     *  正文
     */
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconFrame), CGRectGetMaxY(self.timeFrame)) + JSSStatusCellMargin;
    CGFloat contentX = iconX;
    CGFloat width = screenWidth - contentX * 2;

    // 重新计算微博正文的大小
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentFrame = (CGRect){{contentX, contentY}, contentSize};
    
    /**
     *  图片
     */
    CGFloat originalHeight;
    if (status.pic_urls.count) { // 有图片
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentFrame) + JSSStatusCellMargin;
        self.photosFrame = (CGRect){{photoX, photoY}, [JSSStatusPhotosView sizeWithCount:status.pic_urls.count]};
        originalHeight = CGRectGetMaxY(self.photosFrame) + JSSStatusCellMargin;
    } else {
        originalHeight = CGRectGetMaxY(self.contentFrame) + JSSStatusCellMargin;
    }
    
    /**
     *  上半部分视图的父视图
     */
    self.originalFrame = CGRectMake(0, JSSStatusCellMargin, screenWidth, originalHeight);
    
    CGFloat cellHeight;
    if (status.retweeted_status) { // 有转发的时候
        /**
         *  转发的微博正文 + 昵称
         */
        CGFloat retweetContentX = JSSStatusCellMargin;
        CGFloat retweetContentY = JSSStatusCellMargin;
        CGSize retweetContentSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        self.retweetContentLabelFrame = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        /**
         *  转发的微博图片
         */
        CGFloat retweetHeight;
        if (status.retweeted_status.pic_urls.count) { // 转发微博有图片
            CGFloat retweetPhotoX = JSSStatusCellMargin;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelFrame) + JSSStatusCellMargin;
            self.retweetPhotosImageViewFrame = (CGRect){{retweetPhotoX, retweetPhotoY}, [JSSStatusPhotosView sizeWithCount:status.retweeted_status.pic_urls.count]};
            retweetHeight = CGRectGetMaxY(self.retweetPhotosImageViewFrame);
        } else {
            retweetHeight = CGRectGetMaxY(self.retweetContentLabelFrame);
        }
        
        /**
         *  转发微博视图
         */
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalFrame);
        CGFloat retweetViewW = screenWidth;
        self.retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetHeight);
        cellHeight = CGRectGetMaxY(self.retweetViewFrame) + JSSStatusCellMargin;
    } else { // 没有转发的时候
        cellHeight = CGRectGetMaxY(self.originalFrame);
    }
    
    /**
     *  工具条视图
     */
    CGFloat toolbarX = 0;
    CGFloat toolbarY = cellHeight;
    CGFloat toolbarW = screenWidth;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /**
     *  高度
     */
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}

@end
