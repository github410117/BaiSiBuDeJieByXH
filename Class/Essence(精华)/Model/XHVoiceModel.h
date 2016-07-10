//
//  XHVoiceModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHVoiceModel : NSObject
/**
 *  下载url
 */
@property (nonatomic,strong) NSArray *download_url;

/**
 *  音频时间
 */
@property (nonatomic,assign) NSInteger duration;

/**
 *  高度
 */
@property (nonatomic,assign) NSInteger height;

/**
 *  播放次数
 */
@property (nonatomic,assign) NSInteger playcount;

/**
 *  专辑图片数组
 */
@property (nonatomic,strong) NSArray *thumbnail;

//宽度
@property (nonatomic,assign) NSInteger width;
@end
