//
//  XHVideoModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHVideoModel : NSObject
/**
 *  下载url数组
 */
@property (nonatomic,strong) NSArray *download;

/**
 *  高度
 */
@property (nonatomic,assign) NSInteger height;

/**
 *  宽度
 */
@property (nonatomic,assign) NSInteger width;

/**
 *  播放次数
 */
@property (nonatomic,assign) NSInteger playcount;

/**
 *  内容下载地址
 */
@property (nonatomic,strong) NSArray *video;

/**
 *  时长
 */
@property (nonatomic,assign) NSInteger duration;

/**
 *  缩略图
 */
@property (nonatomic,strong) NSArray *thumbnail;
@end
