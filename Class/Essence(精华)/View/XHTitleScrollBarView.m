//
//  XHTitleScrollBarView.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHTitleScrollBarView.h"

@interface XHTitleScrollBarView ()

//滚动条ScrollView
@property (nonatomic ,strong) UIScrollView *topScrollView;

@end

@implementation XHTitleScrollBarView

//设置顶部文字标题
- (void)setupTopTitleView
{
    //创建顶部标题，因为标题可以滚动所以用UIScrollView创建
    _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 35)];
    
    //给UIScrollView设置背景图片
    UIImage *image = GetImage(@"navigationbarBackgroundWhite");
    [_topScrollView setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    //把ScrollView添加到当前View上
    [self addSubview:_topScrollView];
}



@end
