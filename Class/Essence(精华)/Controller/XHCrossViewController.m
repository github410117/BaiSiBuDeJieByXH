//
//  XHCrossViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHCrossViewController.h"
#import "XHBaseTableViewController.h"

@interface XHCrossViewController ()
@property (nonatomic, strong) XHBaseTableViewController *crossCtr;
@end

@implementation XHCrossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self addChildCtr];
    self.titleBtnCount = 4;
    // Do any additional setup after loading the view.
}

//设置导航和背景
- (void)setNavigation {
    self.view.backgroundColor = RGB(244, 244, 244);
    self.navigationItem.title = @"穿越";
}

- (void)addChildCtr {
    //全部
    XHBaseTableViewController *all = [[XHBaseTableViewController alloc] init];
    all.title = @"全部";
    all.connectionUrl = XHCrossAllURL;
    [self addChildViewController:all];
    
    //图片
    XHBaseTableViewController *picture = [[XHBaseTableViewController alloc]init];
    picture.title = @"图片";
    picture.connectionUrl = XHCrossPictureURL;
    [self addChildViewController:picture];
    
    //视频
    XHBaseTableViewController *video = [[XHBaseTableViewController alloc] init];
    video.title = @"视频";
    video.connectionUrl = XHCrossVideoURL;
    [self addChildViewController:video];
    
    //段子
    XHBaseTableViewController *text = [[XHBaseTableViewController alloc]init];
    text.title = @"段子";
    text.connectionUrl = XHCrossTextURL;
    [self addChildViewController:text];
    
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
