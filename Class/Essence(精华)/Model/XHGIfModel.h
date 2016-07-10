//
//  XHGIfModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHGIfModel : NSObject

/** 下载链接 */
@property (nonatomic,strong) NSArray *download_url;

/** 缩略图数组 */
@property (nonatomic,strong) NSArray *gif_thumbnail;

/** 图片数组 */
@property (nonatomic,strong) NSArray *images;

/** 高度 */
@property (nonatomic,assign) NSInteger height;

/** 宽度 */
@property (nonatomic,assign) NSInteger width;





@end
