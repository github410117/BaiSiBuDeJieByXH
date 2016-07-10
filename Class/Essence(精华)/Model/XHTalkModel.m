//
//  XHTalkModel.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/7.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHTalkModel.h"
#import "XHUserModel.h"
#import "XHGIfModel.h"
#import "XHVideoModel.h"
#import "XHVoiceModel.h"
#import "XHUser3Model.h"


static CGFloat headerHeight = 50;//头像的Y值
static CGFloat margin = 10;//间隙

@implementation XHTalkModel
{
    CGFloat _cellHeight;
}

/**
 *  统一转换属性名，因为在前面直接写id的话会导致引用到系统的id类型
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

/**
 *  说明数组中存储的模型数据类型
 */
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_comment" : @"top_comment"};
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        //段子高度
        
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(Main_Screen_Width - 2 * margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size.height;
        
        //50是头像到最上面的高度，头像42 + 离top 8
        _cellHeight = 50 + 2 * margin + textH;
    
        
        
//        类型为图片
        if ([self.type isEqualToString:@"image"]) {
            CGFloat picX = margin;
            CGFloat picY = textH + 2 * margin + headerHeight;
            CGFloat picW = Main_Screen_Width - 20;
            CGFloat picH = picW * self.image.height / self.image.width;
            
            //如果高度超过了1500.表明是长图
            if (picH >= 1500) {
                picH = 250;
                self.bigPicture = YES;
            }
            
            //设置图片控件的Frame
            _pictureF = CGRectMake(picX, picY, picW, picH);
            
            //重新设置cell高度
            _cellHeight += picH + margin;
        }else if ([self.type isEqualToString:@"gif"]){
            CGFloat picX = margin;
            CGFloat picY = textH + 2 * margin + headerHeight;
            CGFloat picW = Main_Screen_Width - 20;
            CGFloat picH = picW * self.gif.height / self.gif.width;
            
            //如果高度超过了1500.表明是长图
            if (picH >= 1500) {
                picH = 250;
                self.bigPicture = YES;
            }
            
            //设置图片控件的Frame
            _pictureF = CGRectMake(picX, picY, picW, picH);
            
            //重新设置cell高度
            _cellHeight += picH + margin;
        }else if ([self.type isEqualToString:@"video"]) {
            CGFloat videoX = margin;
            CGFloat videoY = textH + headerHeight + 2 * margin;
            CGFloat videoW = Main_Screen_Width - 2 * margin;
            CGFloat videoH = self.video.height * videoW / self.video.width;
            if (videoH > 250) {
                videoH = 300;
            }
            
            //设置Video控件的frame
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + margin;
        }else if ([self.type isEqualToString:@"audio"]) {
            CGFloat voiceX = margin;
            CGFloat voiceY = textH + headerHeight + 2 * margin;
            CGFloat voiceW = Main_Screen_Width - 2 * margin;
            CGFloat voiceH = self.audio.height * voiceW / self.audio.width;
            
            _soundF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + 10;
        }
        
        //处理最热评论
        if (_top_comment) {
            NSString *commentStr = [NSString stringWithFormat:@"%@:%@",_top_comment.u.name,_top_comment.content];
            
            //计算高度
            CGFloat contentH = [commentStr boundingRectWithSize:CGSizeMake(Main_Screen_Width - 20,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size.height;
            
            //这个20是最热评论的标签高度
            _cellHeight += contentH + margin + 20;
        }
        
        //加上点赞那行的高度
        _cellHeight += 35 + margin;
    }
    
    return _cellHeight;
}


@end
