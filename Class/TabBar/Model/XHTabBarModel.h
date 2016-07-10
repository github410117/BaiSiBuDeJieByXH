//
//  XHTabBarModel.h
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHTabBarModel : NSObject

/**TabBar按钮图标*/
@property (nonatomic, copy) NSString *image;
/**TabBar文字*/
@property (nonatomic, copy) NSString *title;
/**TabBar选中图标*/
@property (nonatomic, copy) NSString *selected;


@end
