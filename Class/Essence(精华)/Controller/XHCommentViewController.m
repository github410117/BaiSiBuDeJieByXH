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
#import "XHCommentCell.h"


static NSString *const identifier = @"cell";
static NSString *const commentPreUrl = @"http://api.budejie.com/api/api_open.php?a=dataList&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=comment&client=iphone&data_id=";
static NSString *const commentLastUrl = @"&device=ios%20device&from=ios&hot=1&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&page=1&per=50&udid=&ver=4.2";
@interface XHCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

//最新评论
@property (nonatomic, copy) NSMutableArray *lastNewCommentArray;
@end

@implementation XHCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setBasic];
    [self setTabViewHeader];
    [self setRefresh];

    // Do any additional setup after loading the view from its nib.
}

//设置基本参数
- (void)setBasic {
    self.navigationItem.title = @"评论";
    //设置背景色
    self.myTableView.backgroundColor = RGB(244, 244, 244);
    //注册cell
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XHCommentCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    //估算高度,就不用每个cell都设置高度了,给个大概值
    self.myTableView.estimatedRowHeight = 44;


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
    CGFloat temp = self.talkModel.cellHeight - 10;
    cell.frame = CGRectMake(0, 0, Main_Screen_Width, temp);
    cell.talkModel = self.talkModel;
    [cellHeader addSubview:cell];
    //设置头部视图的高度
    cellHeader.height = temp;
    //加入到头部视图
    self.myTableView.tableHeaderView = cellHeader;
}

//设置刷新控件
- (void)setRefresh {
    //下拉刷新
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    [self.myTableView.mj_header beginRefreshing];

}

//下拉刷新
- (void)downRefresh {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //确定是哪个cell，好对应加载评论
    params[@"data_id"] = self.talkModel.ID;
    
    //拼接Url
    NSString *url = [NSString stringWithFormat:@"%@%@%@",commentPreUrl,self.talkModel.ID,commentLastUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.lastNewCommentArray = [XHTopCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.myTableView.mj_header endRefreshing];
    }];
}


#pragma mark - UITableViewDataSource方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.CommentModel = _lastNewCommentArray[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lastNewCommentArray.count;
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = RGB(244, 244, 244);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, Main_Screen_Width, 30)];
    label.textColor = RGB(67, 67, 67);
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"最新评论";
    [view addSubview:label];
    return view;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}





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
