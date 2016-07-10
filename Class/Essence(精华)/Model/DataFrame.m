//
//  DataFrame.m
//  百思不得姐
//
//  Created by etcxm on 16/6/30.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "DataFrame.h"

static CGFloat headY = 50;//头像的Y值
static CGFloat interval = 8;//头像与正文的间隙

@implementation DataFrame

- (void)setModel:(DataModel *)model {
    _model = model;
    CGFloat contentW = Main_Screen_Width - 28;//段子正文的宽度
    CGFloat contentH = [_model.text boundingRectWithSize:CGSizeMake(contentW,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;//根据文字自适应label高度
    //最大的Y值
    CGFloat maxY = headY + interval * 2 + contentH;
    if (_model.type != TypeTalk) {
        CGFloat mediaViewX = 14;
        CGFloat mediaViewY = maxY;
        CGFloat mediaViewW = contentW;
        CGFloat scale = _model.width / mediaViewW;//比例
        CGFloat mediaViewH = _model.height / scale;
        //控制宽高比
        if (_model.type == TypeVideo && mediaViewH > 250) {
            mediaViewH = 250;
        }if (contentH > 1500) {
            mediaViewH = 300;
        }
        //视频的frame
        self.viewFrame = CGRectMake(mediaViewX, mediaViewY, mediaViewW, mediaViewH);
        NSLog(@"%@",NSStringFromCGRect(self.viewFrame));
        maxY = mediaViewY + mediaViewH + interval;//有视频或图片的最大Y值
    }
    
    //有无热门评论，算Y值
    if (_model.cmtModel) {
        NSLog(@"有热评");
        NSString *content = [NSString stringWithFormat:@"%@ : %@", _model.cmtModel.user.username, _model.cmtModel.content];
        CGFloat hotCommentH = [content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        maxY = hotCommentH + maxY + interval + 20;//20是最热评论的标签高度
    }
    self.cellHeight = maxY + 50;//50为点赞的高度加一点间隙
    
}

@end
