//
//  XHCommentViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/9.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHCommentViewController.h"
#import "XHTalkModel.h"
#import "myContentCell.h"
#import "XHTopCommentModel.h"


static NSString *const identifier = @"myCell";
static NSString *const commentPreUrl = @"http://api.budejie.com/api/api_open.php?a=dataList&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=comment&client=iphone&data_id=";
static NSString *const commentLastUrl = @"&device=ios%20device&from=ios&hot=1&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&page=1&per=50&udid=&ver=4.2";
@interface XHCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

//热评数组
@property (nonatomic, copy) NSArray *hotCommentArray;

//最新评论
@property (nonatomic, copy) NSMutableArray *lastNewCommentArray;
@end

@implementation XHCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setBasic];
    [self setTabViewHeader];

    // Do any additional setup after loading the view from its nib.
}

//设置基本参数
- (void)setBasic {
    self.navigationItem.title = @"评论";
    
    //注册cell
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([myContentCell class]) bundle:nil] forCellReuseIdentifier:identifier];
}

//设置tv头部,用于显示上页的cell
- (void)setTabViewHeader {
    //由于头部视图是个view,所以将cell放到view再放到头部视图
    UIView *cellHeader = [[UIView alloc] init];
    
    //注意，这里需要判断一下，由于点到了详细界面，热评是会取消掉的,就不能将热评加入到cell，需要重新设置一下
    if (_talkModel.top_comment) {
        _talkModel.top_comment = nil;
        //注意，这里一定要将cellHeight的值设置为0,好让cellHeight重新计算一次cell的高度
        [_talkModel setValue:@0 forKey:@"cellHeight"];
    }
    
    myContentCell *cell = [myContentCell myComtentCell];
    //这里的宽度是cell宽度，是要放满屏幕的,不需要写-20
    cell.size = CGSizeMake(Main_Screen_Width , self.talkModel.cellHeight);
    cell.talkModel = self.talkModel;
    [cellHeader addSubview:cell];
    //设置头部视图的高度
    cellHeader.height = self.talkModel.cellHeight;
    //加入到头部视图
    self.myTableView.tableHeaderView = cellHeader;
}

//设置刷新控件
- (void)setRefresh {
    //下拉刷新
    self.myTableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    [self.myTableView.mj_header beginRefreshing];
    
    //上拉刷新
    self.myTableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}

//下拉刷新
- (void)downRefresh {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"data_id"] = self.talkModel.ID;
    
    //拼接Url
    NSString *url = [NSString stringWithFormat:@"%@%@%@",commentPreUrl,self.talkModel.ID,commentLastUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotCommentArray = [XHTopCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.lastNewCommentArray = [XHTopCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.myTableView.mj_header endRefreshing];
    }];
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

//懒加载最近评论数组
- (NSMutableArray *)lastNewCommentArray {
    if (!_lastNewCommentArray) {
        _lastNewCommentArray = [NSMutableArray array];
    }
    return _lastNewCommentArray;
}

@end
