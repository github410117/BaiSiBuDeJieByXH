//
//  XHRightUserModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHRightUserModel : NSObject

/**
 *  头像
 */
@property (nonatomic,strong) NSString *header;

/**
 *  粉丝数量
 */
@property (nonatomic,assign) NSInteger fans_count;

/**
 *  用户名
 */
@property (nonatomic,strong) NSString *screen_name;

/**
 *  是否是Vip
 */
@property (nonatomic,assign,getter = isVip) BOOL is_vip;

@end
