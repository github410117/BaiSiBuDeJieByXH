//
//  XHLeftTabCell.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHLeftTabCell.h"
#import "XHLeftTabModel.h"

@interface XHLeftTabCell ()
@property (weak, nonatomic) IBOutlet UIView *redLine;

@end

@implementation XHLeftTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = RGB(240, 240, 240);
    //设置文本位置
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    // Initialization code
}


- (void)setLeftTabModel:(XHLeftTabModel *)leftTabModel {
    _leftTabModel = leftTabModel;
    //设置类别
    self.textLabel.text = leftTabModel.name;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.height = self.contentView.height - 1;
}


//根据选中的cell来换颜色和红条
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //没被选中的cell红条隐藏
    self.redLine.hidden = !selected;
    //使用三目来设置选中和未被选中的字体颜色
    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    
    UIView *whiteColor = [[UIView alloc]init];
    whiteColor.backgroundColor = [UIColor whiteColor];
    
    UIView *grayColor = [[UIView alloc]init];
    grayColor.backgroundColor = RGB(240, 240, 240);
    //设置背景色，与右边的保持一致
    self.selectedBackgroundView = selected ? whiteColor : grayColor;
}

@end
