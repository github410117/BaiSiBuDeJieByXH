//
//  XHUserModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHUserModel : NSObject

/** 名字 */
@property (nonatomic, strong) NSString *name;

/** 头像Url数组(返回的数组里装了2个url地址) */
@property (nonatomic, strong) NSArray *header;

/** 性别 */
@property (nonatomic, strong) NSString *sex;

/** 是否为会员 */
@property (nonatomic, assign, getter = isVip) BOOL is_v;

/** 内容下载的url数组(有的可能下载不了) */
@property (nonatomic, copy) NSArray *download_url;

/** 大图数组 */
@property (nonatomic, copy) NSArray *big;

/** 中图数组 */
@property (nonatomic, copy) NSArray *medium;

/** 小图数组 */
@property (nonatomic, copy) NSArray *small;

/** 内容的高度 */
@property (nonatomic, assign) NSInteger height;

/** 内容的宽度 */
@property (nonatomic ,assign) NSInteger width;

@end
