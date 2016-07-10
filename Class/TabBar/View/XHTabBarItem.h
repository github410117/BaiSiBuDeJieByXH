//
//  XHTabBarItem.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHTabBarModel;
@interface XHTabBarItem : UITabBarItem

/**
 *  重写初始化方法
 */
- (instancetype)initWithTabBarModel:(XHTabBarModel *)tabBarModel;

@end
