//
//  PictureView.m
//  百思不得姐
//
//  Created by etcxm on 16/7/1.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "PictureView.h"
#import "XHTalkModel.h"
#import "DALabeledCircularProgressView.h"
#import "UIImageView+WebCache.h"
#import "XHShowPicViewController.h"


@interface PictureView ()
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *ProgressView;
- (IBAction)bigImage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;//图片
@property (weak, nonatomic) IBOutlet UIButton *bigImageOutlet;//点击查看大图
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;//背景(百思不得姐logo)
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;//gif小图标

@property (nonatomic , strong) UIImage *nextShowImage;//用于传给下一个页面的值

@end

@implementation PictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    //取消UIView的自动调整布局
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加单击事件
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)]];
    //设置为能与用户交互
    self.imageView.userInteractionEnabled = YES;
    
}

//点击图片就全屏显示
- (void)showImage {
    XHShowPicViewController *picShow = [[XHShowPicViewController alloc] init];
    picShow.talkModel = self.talkModel;
    picShow.image = _nextShowImage;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picShow animated:YES completion:nil];
}


- (void)setTalkModel:(XHTalkModel *)talkModel {
    _talkModel = talkModel;
    
    //区分是普通图片还是gif图片
    NSString *url;
    if ([self.talkModel.type isEqualToString:@"image"]) {
        url = self.talkModel.image.download_url.firstObject;
    } else if ([self.talkModel.type isEqualToString:@"gif"]) {
        url = self.talkModel.gif.images.firstObject;
    }
    
    
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //注意要写个1.0，刚开始没写1.0，/出来是整数，我说怎么进度条直接0到1了
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.bgImage.hidden = NO;
        self.ProgressView.hidden = NO;
        self.ProgressView.progressLabel.textColor = [UIColor whiteColor];
        self.ProgressView.roundedCorners = 3;
        self.ProgressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
        [self.ProgressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //存着，待会传到下个界面展示
        _nextShowImage = image;
        self.bgImage.hidden = YES;
        self.ProgressView.hidden = YES;
        //判断是否为gif来隐藏git小图标
        self.gifImage.hidden = [self.talkModel.type isEqualToString:@"image"];
        
        //判断是否显示“点击查看全图”
        if (talkModel.isBigPicture) {//大图
            self.bigImageOutlet.hidden = NO;
        }else{//非大图
            self.bigImageOutlet.hidden = YES;
            
        }
        
    }];
}



//点击大图
- (IBAction)bigImage:(UIButton *)sender {
    [self showImage];
}
@end
