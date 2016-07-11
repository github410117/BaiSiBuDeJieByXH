//
//  XHCommentCell.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/10.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHCommentCell.h"
#import "XHTopCommentModel.h"
#import "UIImageView+WebCache.h"

@interface XHCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UIImageView *SexImage;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UILabel *textView;

@property (weak, nonatomic) IBOutlet UILabel *likeCountView;
@end

@implementation XHCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCommentModel:(XHTopCommentModel *)commentModel
{
    _CommentModel = commentModel;
    //设置头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_CommentModel.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    //设置性别图像,根据返回的关键字判断
    self.SexImage.image = [commentModel.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    //评论内容
    self.textView.text = commentModel.content;
    //用户名
    self.nameView.text = commentModel.user.username;
    //点赞数
    self.likeCountView.text = commentModel.like_count;
}


//设置cell之间的距离
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    frame.origin.y += 1;
    [super setFrame:frame];
}

@end
