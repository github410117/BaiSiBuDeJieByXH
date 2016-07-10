//
//  XHTaBbarViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHTaBbarViewController.h"
#import "XHAttentionViewController.h"
#import "XHMeViewController.h"
#import "XHNewViewController.h"
#import "XHEssenceViewController.h"
#import "XHPublishViewController.h"
#import "XHTabBarModel.h"
#import "XHTabBarItem.h"
#define TabBarPlist @"TabBar"

@interface XHTaBbarViewController ()

//TabBar的信息数组
@property (nonatomic, strong) NSArray *tabBarPlistArray;

//模型数组
@property (nonatomic, copy) NSMutableArray *modelArray;

@end

@implementation XHTaBbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //字典转模型
    [self dicToModel];
    
    //设置控制器
    [self setUpTabBarCtr];
}



/**
 *  设置TabBar上的控制器
 */
- (void)setUpTabBarCtr {
    //精选
    XHEssenceViewController *essence = [[XHEssenceViewController alloc] init];
    UINavigationController *navigationEssence = [self tableViewCtr:essence Num:0];
    
    //最新
    XHNewViewController *new = [[XHNewViewController alloc] init];
    UINavigationController *navigationNew = [self tableViewCtr:new Num:1];
    
    //发布
    XHPublishViewController *publish = [[XHPublishViewController alloc] init];
    UINavigationController *navigationPublish = [self tableViewCtr:publish Num:2];
    
    //关注
    XHAttentionViewController *attention = [[XHAttentionViewController alloc] init];
    UINavigationController *navigationAttention = [self tableViewCtr:attention Num:3];
    
    //我
    XHMeViewController *me = [[XHMeViewController alloc] init];
    UINavigationController *navigationMe = [self tableViewCtr:me Num:4];
    
    //加入到TabBar
    [self setViewControllers:@[navigationEssence,navigationNew,navigationPublish,navigationAttention,navigationMe]];
}



/**
 *  设置导航栏并绑定Item(UIVIewCtr)
 */
- (UINavigationController *)tableViewCtr:(UIViewController *)tableViewCtr Num:(NSInteger)num {
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:tableViewCtr];
    navigation.tabBarItem = [self item:num];
    return navigation;
}



/**
 *  用来设置TabBar上的item
 *
 *  @param num 对应模型数组的第几位
 *
 *  @return 初始化好的item
 */
- (UITabBarItem *)item:(NSInteger)num {
    XHTabBarModel *TBModel = [[XHTabBarModel alloc] init];
    TBModel = _modelArray[num];
    UITabBarItem *item = [[XHTabBarItem alloc] initWithTabBarModel:TBModel];
    return item;
}



/**
 *  字典转模型(字典数组----->模型数组)
 */
- (void)dicToModel {
    self.modelArray = [NSMutableArray array];
    self.modelArray = [XHTabBarModel mj_objectArrayWithKeyValuesArray:self.tabBarPlistArray];
}


/**
 *  懒加载TaBbar的plist文件信息(一定要注意，这里不能写self)
 */
- (NSArray *)tabBarPlistArray {
    if (!_tabBarPlistArray) {
        _tabBarPlistArray = [GetPlistArray arrayWithString:TabBarPlist];
    }
    return _tabBarPlistArray;
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
