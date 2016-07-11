//
//  XHAttentionViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHAttentionViewController.h"

@interface XHAttentionViewController ()

@end

@implementation XHAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)setNavigation {
    self.navigationItem.title = @"关注";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:normalImage(GetImage(@"friendsRecommentIcon")) style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
}

- (void)leftBtnClick {
    NSLog(@"点了左边的按钮");
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

@end
