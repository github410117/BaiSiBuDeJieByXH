//
//  XHHeaderModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHHeaderModel : NSObject

/**
 *  大图数组
 */
@property (nonatomic,strong) NSArray *big;

/**
 *  中图数组
 */
@property (nonatomic,strong) NSArray *medium;

/**
 *  小图数组
 */
@property (nonatomic,strong) NSArray *small;
@end
