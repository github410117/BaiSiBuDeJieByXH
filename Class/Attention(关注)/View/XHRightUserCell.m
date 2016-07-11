//
//  XHRightUserCell.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHRightUserCell.h"

@interface XHRightUserCell ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

//用户名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//关注数
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

//黄钻
@property (weak, nonatomic) IBOutlet UIImageView *diamon;

@end

@implementation XHRightUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}










//设置cell的间距
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
