//
//  XHNetRedModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XHHeaderModel;
@interface XHNetRedModel : NSObject

/**
 *  头像
 */
@property (nonatomic,strong) XHHeaderModel *header;

/**
 *  名字
 */
@property (nonatomic,strong) NSString *name;

/**
 *  是否是VIP
 */
@property (nonatomic,assign,getter = isVip) BOOL jie_v;

/**
 *  简介
 */
@property (nonatomic,strong) NSString *introduction;

@end
