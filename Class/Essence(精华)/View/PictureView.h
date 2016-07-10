//
//  PictureView.h
//  百思不得姐
//
//  Created by etcxm on 16/7/1.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHTalkModel;
@interface PictureView : UIView

/**
 *  所有数据
 */
@property (nonatomic, strong) XHTalkModel *talkModel;
+ (instancetype)pictureView;
@end
