//
//  XHTalkModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHTopCommentModel.h"
#import "XHGIfModel.h"
#import "XHVideoModel.h"
#import "XHUserModel.h"
#import "XHVoiceModel.h"


@interface XHTalkModel : NSObject

/**
 *  ID
 */
@property (nonatomic,strong) NSString *ID;

/**
 *  发布时间
 */
@property (nonatomic,strong) NSString *passtime;

/**
 *  正文内容
 */
@property (nonatomic,strong) NSString *text;

/**
 *  点赞数量
 */
@property (nonatomic,assign) NSInteger up;

/**
 *  点踩数量
 */
@property (nonatomic,assign) NSInteger down;

/**
 *  转发数量
 */
@property (nonatomic,assign) NSInteger forward;

/**
 *  评论数量
 */
@property (nonatomic,assign) NSInteger comment;

/**
 *  内容类型
 */
@property (nonatomic,strong) NSString *type;

/**
 *  姓名和头像
 */
@property (nonatomic,strong) XHUserModel *u;

/**
 *  GIF图片
 */
@property (nonatomic,strong) XHGIfModel *gif;

/**
 *  image图片
 */
@property (nonatomic,strong) XHUserModel *image;

/**
 *  视频模型
 */
@property (nonatomic,strong) XHVideoModel *video;

/**
 *  声音模型
 */
@property (nonatomic,strong) XHVoiceModel *audio;

/**
 *  评论模型
 */
@property (nonatomic,strong) XHTopCommentModel *top_comment;


/**
 *  cell的高度
 */
@property (nonatomic,assign,readonly) CGFloat cellHeight;

/**
 *  图片的frame
 */
@property (nonatomic,assign,readonly) CGRect pictureF;

/**
 *  声音类型frame
 */
@property (nonatomic, assign, readonly) CGRect soundF;

/**
 *  视频类型frame
 */
@property (nonatomic,assign,readonly) CGRect videoF;

/**
 *  是否为大图
 */
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;

/**
 *  下载进度
 */
@property (nonatomic,assign) CGFloat pictureProgress;


@end
