//
//  XHAttentionViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHAttentionViewController.h"
#import "XHRecommendAttViewController.h"

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
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:back];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)leftBtnClick {
    XHRecommendAttViewController *recommendAtt = [[XHRecommendAttViewController alloc] init];
    recommendAtt.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recommendAtt animated:YES];
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
