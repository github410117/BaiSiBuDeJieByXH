//
//  XHRecommendAttViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHRecommendAttViewController.h"

@interface XHRecommendAttViewController ()<UITableViewDelegate,UITableViewDataSource>

//左侧分栏
@property (weak, nonatomic) IBOutlet UITableView *leftTab;

//左侧分栏数据
@property (nonatomic, copy) NSArray *leftTabArray;

//右侧分栏
@property (weak, nonatomic) IBOutlet UITableView *rightTab;

@end

@implementation XHRecommendAttViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
