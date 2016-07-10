//
//  DataFrame.h
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface DataFrame : NSObject

@property (nonatomic, strong) DataModel *model;//所有数据
@property (nonatomic, assign) CGFloat cellHeight;//算出来的cell的高度
@property (nonatomic, assign) CGRect viewFrame;//视频、图片、声音的尺寸


@end
