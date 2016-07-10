//
//  XHTopCommentModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHUser3Model.h"

@class XHUserModel;
@interface XHTopCommentModel : NSObject

/**
 *  ID
 */
@property (nonatomic,strong) NSString *ID;

/**
 *  评论内容
 */
@property (nonatomic,strong) NSString *content;

/**
 *  点赞数
 */
@property (nonatomic,strong) NSString *like_count;


/**
 *  声音时长
 */
@property (nonatomic,assign) NSNumber *voicetime;

//User3模型
@property (nonatomic,strong) XHUser3Model *u;

//user模型
@property (nonatomic,strong) XHUserModel *user;

@end
