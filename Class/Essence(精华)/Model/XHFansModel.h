//
//  XHFansModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XHHeaderModel;
@interface XHFansModel : NSObject

/**
 *  头像
 */
@property (nonatomic,strong) XHHeaderModel *header;

/**
 *  名字
 */
@property (nonatomic,strong) NSString *name;

/**
 *  是否VIP
 */
@property (nonatomic,assign,getter = isVip) BOOL jie_v;

/**
 *  前一天新加粉丝数
 */
@property (nonatomic,strong) NSString *fans_add_yesterday;

@end
