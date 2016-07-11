//
//  XHLeftTabModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHLeftTabModel : NSObject

/**
 *  对应的ID
 */
@property (nonatomic,assign) NSInteger ID;

/**
 *  分类的名称
 */
@property (nonatomic,strong) NSString *name;

/**
 *  每个分类对应的用户数量
 */
@property (nonatomic,assign) NSInteger count;

//这个类对应的用户总数据
@property (nonatomic,strong) NSMutableArray *users;
//总数
@property (nonatomic,assign) NSInteger total;
//当前页码
@property (nonatomic,assign) NSInteger currentPage;
@end
