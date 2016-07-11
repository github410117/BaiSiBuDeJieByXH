//
//  myContentCell.m
//  百思不得姐
//
//  Created by xh on 16/7/2.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "myContentCell.h"
#import "XHTalkModel.h"
#import "XHUserModel.h"
#import "XHUser3Model.h"
#import "PictureView.h"
#import "myVideoView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "XHCommentViewController.h"
#import "XHCommentCell.h"


@interface myContentCell ()
@property (weak, nonatomic) IBOutlet UIButton *headImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *userName;//ID昵称

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *content;//正文
@property (weak, nonatomic) IBOutlet UILabel *hotComment;//热评
@property (weak, nonatomic) IBOutlet UIButton *zan;
@property (weak, nonatomic) IBOutlet UIButton *cai;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIView *hotCommentView;

@property (nonatomic, strong) PictureView *pictureView;

@property (nonatomic, strong) myVideoView *myVideoView;
- (IBAction)rightAlertBtn:(UIButton *)sender;


@end

@implementation myContentCell

//解决重用
- (void)prepareForReuse {
    
    [super prepareForReuse];
    //滑出屏幕停止视频播放
    [self.myVideoView reset];
}


+ (instancetype)myComtentCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTalkModel:(XHTalkModel *)talkModel {
    _talkModel = talkModel;
    
    //设置头像
    [self.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:talkModel.u.header.lastObject] forState:UIControlStateNormal];
    
    //设置用户名
    self.userName.text = talkModel.u.name;
    
    //设置发帖时间
    self.releaseTime.text = talkModel.passtime;
    
    //设置正文内容
    self.content.text = talkModel.text;
    
    //设置顶、踩、分享等
    ;
    [self.zan setTitle:[NSString stringWithFormat:@"%ld",talkModel.up] forState:UIControlStateNormal];
    [self.cai setTitle:[NSString stringWithFormat:@"%ld",talkModel.down] forState:UIControlStateNormal];
    [self.share setTitle:[NSString stringWithFormat:@"%ld",talkModel.forward] forState:UIControlStateNormal];
    [self.comment setTitle:[NSString stringWithFormat:@"%ld",talkModel.comment] forState:UIControlStateNormal];
    
    if ([talkModel.type isEqualToString:@"image"] || [talkModel.type isEqualToString:@"gif"]) {
        //如果类型为图片，将自己视频和音频控件隐藏，图片控件显示
        self.myVideoView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.talkModel = talkModel;
        self.pictureView.frame = talkModel.pictureF;
    }else if ([talkModel.type isEqualToString:@"video"]) {
        //如果类型是视频，将图片和声音控件隐藏，视频控件显示
        self.pictureView.hidden = YES;
        self.myVideoView.hidden = NO;
        self.myVideoView.talkModel = talkModel;
        self.myVideoView.frame = talkModel.videoF;
    }else {
        //段子类型,将所有控件都隐藏(音频、视频、图片)
        self.pictureView.hidden = YES;
        self.myVideoView.hidden = YES;
    }
    
    
    
    //判断是否有热评
    if (!talkModel.top_comment) {
        self.hotCommentView.hidden = YES;
    } else {
        //有热评就设置内容
        self.hotCommentView.hidden = NO;
        self.hotComment.text = [NSString stringWithFormat:@"%@:%@",talkModel.top_comment.u.name,talkModel.top_comment.content];
    }
//    talkModel.top_comment ? self.hotCommentView.hidden = NO : self.hotCommentView.hidden = YES;
}


//设置cell之间的距离
-(void)setFrame:(CGRect)frame {
   
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}

/**
 *  图片cell懒加载
 */
- (PictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [PictureView pictureView];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

/**
 *  视频cell懒加载
 */
- (myVideoView *)myVideoView
{
    if (!_myVideoView) {
        _myVideoView = [myVideoView videoView];
        [self.contentView addSubview:_myVideoView];
    }
    return _myVideoView;
}



- (IBAction)rightAlertBtn:(UIButton *)sender {
    
}

























- (void)awakeFromNib {

    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
