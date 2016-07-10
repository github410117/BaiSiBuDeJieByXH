//
//  XHEssenceViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHEssenceViewController.h"
#import "XHBaseTableViewController.h"
#import "XHScrollBarBaseViewController.h"
#define scrollBar @"scrollBar"
#define allUrl @"AllURL"



@interface XHEssenceViewController ()
{
    UICollectionView *collection;
}
@property (nonatomic, strong) UIScrollView *topScrollView;

//滚动条内容数组
@property (nonatomic, copy) NSArray *scrollBarArray;

@property (nonatomic, copy) NSArray *urlArray;

@end

@implementation XHEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNavigation];
    [self addAllChildViewController];

    self.titleBtnCount = 6;

    
}






/**
 *  设置导航栏(Logo+Item)
 */
- (void)setNavigation {
    //设置logo
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    titleImage.image = GetImage(@"MainTitle");
    titleImage.contentMode = UIViewContentModeCenter;
    [self.navigationItem setTitleView:titleImage];
    //设置左右两边的item
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:normalImage(GetImage(@"nav_item_game_icon~iphone")) style:UIBarButtonItemStylePlain target:self action:@selector(trophyClick)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:normalImage(GetImage(@"RandomAcross~iphone")) style:UIBarButtonItemStylePlain target:self action:@selector(crossClick)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildViewController {
    //使用循环添加子控制器
    for (int i = 0; i < self.scrollBarArray.count; ++i) {
        XHBaseTableViewController *titleCtr = [[XHBaseTableViewController alloc] init];
        titleCtr.title = self.scrollBarArray[i];
        titleCtr.connectionUrl = self.urlArray[i];
        [self addChildViewController:titleCtr];
    }
    
}



# pragma mark - 导航栏左右两边的item事件

- (void)trophyClick {
    NSLog(@"点击了奖杯");
}

- (void)crossClick {
    NSLog(@"点击了穿越");
}



/**
 *  懒加载滚动条的Plist文件
 */
- (NSArray *)scrollBarArray {
    if (!_scrollBarArray) {
        _scrollBarArray = [GetPlistArray arrayWithString:scrollBar];
    }
    return _scrollBarArray;
}

- (NSArray *)urlArray {
    if (!_urlArray) {
        _urlArray = [GetPlistArray arrayWithString:allUrl];
    }
    return _urlArray;
}
@end
