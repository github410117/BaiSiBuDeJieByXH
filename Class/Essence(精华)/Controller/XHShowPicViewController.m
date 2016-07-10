//
//  XHShowPicViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/8.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHShowPicViewController.h"
#import "XHTalkModel.h"

@interface XHShowPicViewController ()
- (IBAction)back:(UIButton *)sender;//返回
- (IBAction)save:(id)sender;//保存
- (IBAction)forward:(UIButton *)sender;//转发
- (IBAction)comments:(UIButton *)sender;//评论
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;//用于加在scrollView上

@end

@implementation XHShowPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showImage];
}

- (void)showImage {
    _imageView = [[UIImageView alloc] init];
    //开始交互功能
    _imageView.userInteractionEnabled = YES;
    //添加单击事件(点击图片返回)有时间可以添加双击放大
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    [_scrollView addSubview:_imageView];
    
    //设置显示图片尺寸
    CGFloat picX = 0;
    CGFloat picY = 0;
    CGFloat picW = Main_Screen_Width;
    CGFloat picH = 0;
    
    //根据类型来设置高度
    if ([_talkModel.type isEqualToString:@"image"]) {
        picH = picW * _talkModel.image.height / _talkModel.image.width;
    }else {
        picH = picW * _talkModel.gif.height / _talkModel.gif.width;
    }
    
    //判断高度是否超出屏幕，超过将使用滑动显示
    if (picH > Main_Screen_Height) {
        _imageView.frame = CGRectMake(picX, picY, picW, picH);
        _scrollView.contentSize = CGSizeMake(0, picH);
    }else {
        //不足一个屏幕，设置centerY在屏幕正中间,centerX不用设置，因为是0，显示是屏幕宽度
        _imageView.size = CGSizeMake(picW, picH);
        _imageView.centerY = Main_Screen_Height * 0.5;
    }
    _imageView.image = _image;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//返回按钮
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存按钮
- (IBAction)save:(id)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showWithStatus:@"图片未下载完成!"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (IBAction)forward:(UIButton *)sender {
    NSLog(@"跳转到转发界面");
}

- (IBAction)comments:(UIButton *)sender {
    NSLog(@"跳转到评论界面");
}
@end
