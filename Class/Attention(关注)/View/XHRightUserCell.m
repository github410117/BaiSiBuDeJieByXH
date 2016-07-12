//
//  XHRightUserCell.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHRightUserCell.h"
#import "UIImageView+WebCache.h"
#import "XHRightUserModel.h"

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

- (void)setRightUsreModel:(XHRightUserModel *)rightUsreModel {
    _rightUsreModel = rightUsreModel;
    
    //设置头像
    [self.imageVIew sd_setImageWithURL:[NSURL URLWithString:rightUsreModel.header] placeholderImage:GetImage(@"defaultTagIcon")];
    
    //设置用户名
    self.nameLabel.text = rightUsreModel.screen_name;
    
    //设置关注数
    self.countLabel.text = [NSString stringWithFormat:@"%ld人关注",rightUsreModel.fans_count];
    
    //判断是否为vip
    if (rightUsreModel.is_vip) {
        self.nameLabel.textColor = [UIColor redColor];
        self.diamon.hidden = NO;
    }else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.diamon.hidden = YES;
    }
    
}








//设置cell的间距
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
