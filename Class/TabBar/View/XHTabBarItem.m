//
//  XHTabBarItem.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHTabBarItem.h"
#import "XHTabBarModel.h"

@implementation XHTabBarItem

- (instancetype)initWithTabBarModel:(XHTabBarModel *)tabBarModel
{
    if (self = [super init]) {
        //设置TabBar按钮上的文字
        self.title = tabBarModel.title;
        //设置item字体的颜色
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil];
        [self setTitleTextAttributes:dic forState:UIControlStateNormal];
        //设置item选中后字体的颜色
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor] ,NSForegroundColorAttributeName, nil];
        [self setTitleTextAttributes:dic1 forState:UIControlStateSelected];
        //设置item正常图片和选择后的图片
        if (tabBarModel.title.length == 0) {
            self.image = GetImage(tabBarModel.image);
            self.selectedImage = GetImage(tabBarModel.selected);
            self.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else {
            self.image = GetImage(tabBarModel.image);
            self.selectedImage = GetImage(tabBarModel.selected);
            //设置显示真实图片，而不是系统默认蓝色图片,不设置这个属性,会导致加载出来的图片是蓝色
            self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
    return self;
}

@end
