//
//  XHNewViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHNewViewController.h"
#import "XHBaseTableViewController.h"

@interface XHNewViewController ()

@end

@implementation XHNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self addAllChildViewController];
    self.titleBtnCount = 6;
    // Do any additional setup after loading the view from its nib.
}


//设置导航栏
- (void)setNavigation {
    //设置logo
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 271, 200)];
    titleImage.image = GetImage(@"MainTitle");
    titleImage.contentMode = UIViewContentModeCenter;
    [self.navigationItem setTitleView:titleImage];
    self.view.backgroundColor = RGB(244, 244, 244);
}

//添加所有的子控制器
- (void)addAllChildViewController
{
    
    //全部
    XHBaseTableViewController *allVc = [[XHBaseTableViewController alloc]init];
    allVc.title = @"全部";
    allVc.connectionUrl = XHNewAllURL;
    [self addChildViewController:allVc];
    
    //视频
    XHBaseTableViewController *videoVc = [[XHBaseTableViewController alloc]init];
    videoVc.title = @"视频";
    videoVc.connectionUrl = XHNewVideoURL;
    [self addChildViewController:videoVc];
    
    //图片
    XHBaseTableViewController *pictureVc = [[XHBaseTableViewController alloc]init];
    pictureVc.title = @"图片";
    pictureVc.connectionUrl = XHNewPictureURL;
    [self addChildViewController:pictureVc];
    
    //段子
    XHBaseTableViewController *textVc = [[XHBaseTableViewController alloc]init];
    textVc.title = @"段子";
    textVc.connectionUrl = XHNewTextURL;
    [self addChildViewController:textVc];
    
    //网红
    XHBaseTableViewController *starVc = [[XHBaseTableViewController alloc]init];
    starVc.title = @"网红";
    starVc.connectionUrl = XHNewStartURL;
    [self addChildViewController:starVc];
    
    //美女
    XHBaseTableViewController *girlVc = [[XHBaseTableViewController alloc]init];
    girlVc.title = @"美女";
    girlVc.connectionUrl = XHNewGirlURL;
    [self addChildViewController:girlVc];
    
    //游戏
    XHBaseTableViewController *gameVc = [[XHBaseTableViewController alloc]init];
    gameVc.title = @"游戏";
    gameVc.connectionUrl = XHNewGameURL;
    [self addChildViewController:gameVc];
    
    
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
