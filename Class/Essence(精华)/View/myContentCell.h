//
//  myContentCell.h
//  百思不得姐
//
//  Created by xh on 16/7/2.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHTalkModel;
@interface myContentCell : UITableViewCell
/**
 *  所有数据
 */
@property (nonatomic, strong) XHTalkModel *talkModel;
@property (weak, nonatomic) IBOutlet UIButton *showComment;
+ (instancetype)myComtentCell;
@end
