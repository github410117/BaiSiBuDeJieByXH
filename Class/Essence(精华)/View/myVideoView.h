//
//  VideoView.h
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XHTalkModel;
@interface myVideoView : UIView
/**
 *  所有数据
 */
@property (nonatomic, strong) XHTalkModel *talkModel;


- (void)reset;
+ (instancetype)videoView;
@end
