//
//  VoiceView.m
//  百思不得姐
//
//  Created by xh on 16/7/2.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "myVoiceView.h"
#import "XHTalkModel.h"

@interface myVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;//专辑封面
@property (weak, nonatomic) IBOutlet UIButton *playBtnOutlet;//播放按钮
@property (weak, nonatomic) IBOutlet UILabel *playCount;//播放次数
@property (weak, nonatomic) IBOutlet UILabel *playTime;//播放时间
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;//百思logo

@end

@implementation myVoiceView

- (void)awakeFromNib {
    //设置图片可以与用户交互
    self.imageView.userInteractionEnabled = YES;
    
    //给图片添加点击手势
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVoice)]];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)showVoice {
    NSLog(@"音频的点击效果");
}

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTalkModel:(XHTalkModel *)talkModel {
    _talkModel = talkModel;
    
    //设置播放次数
    //根据播放次数的字符长度来设置显示label的宽度
    NSString *str = [NSString stringWithFormat:@"%ld播放",talkModel.audio.playcount];
    CGFloat contentW = [str boundingRectWithSize:CGSizeMake(300,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width;
    self.playCount.text = str;
    CGRect frame = self.playCount.frame;
    frame.size.width = contentW;
    //设置音频时长
    self.playTime.text = [NSString stringWithFormat:@"%02ld:%02ld",talkModel.audio.duration / 60, talkModel.audio.duration % 60];
}

@end
