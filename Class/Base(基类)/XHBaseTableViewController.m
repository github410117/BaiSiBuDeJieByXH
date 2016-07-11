//
//  XHBaseTableViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "myContentCell.h"
#import "XHTalkModel.h"
#import "XHCommentViewController.h"


//定义标识符
static NSString *const identifier = @"myCell";

@interface XHBaseTableViewController ()
//请求回来的数据数组
@property (nonatomic, copy) NSMutableArray *dataArray;

//当前页码
@property (nonatomic, assign) NSInteger currentPage;

//获取下一页需要的参数（官方API是发送maxtime）
@property (nonatomic, copy) NSNumber *np;

@end

@implementation XHBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self setUpRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/**
 *  懒加载初始化数据数组
 */
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/**
 *  设置tableview的参数
 */
- (void)setTableView {
    //设置tableview的位置,因为加入到UIcollection里的时候是全屏的，要设置位置在滚动条下，64 = 导航栏44 + 状态栏20 25是滚动条35 - 10，因为cell有个距离为10
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 25, 0, self.tabBarController.tabBar.height, 0);
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([myContentCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    //设置Tableview的背景色，让cell看起来才有分段效果
    self.view.backgroundColor = RGB(240, 240, 240);
    
    //取消Tableview的分栏横线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //取消自动布局，自己手动
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

/**
 *  设置刷新控件
 */
- (void)setUpRefresh {
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //自动加载一次下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    //上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
}

//下拉刷新加载数据
- (void)loadData {
    
    //创建请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:self.connectionUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //存储下一次需要的参数
        self.np = responseObject[@"info"][@"np"];
        
        //字典转模型
        _dataArray = [XHTalkModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        //因为在最上面才能下拉刷新，所以当前页设置为0
        self.currentPage = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //即使失败也结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

//上拉加载更多数据
- (void)getMoreData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"np"] = self.np;
    param[@"page"] = @(++self.currentPage);
    //传入参数的问题，由于是青花瓷请求的url，不像API直接传参数可以获取下一页数据，0-20.json只需要更改后面这个0就可以请求下一页数据,也就是API中的maxtime参数，这里面是np,需要拼接url
    
    //先找出要拼接的位置
    NSRange range = [_connectionUrl rangeOfString:@"4.2/"];
    //截取前面的url（http://s.budejie.com/topic/tag-topic/64/hot/bs0315-iphone-4.2/）
    NSString *previousUrl = [_connectionUrl substringToIndex:range.location + 4];
    //开始拼接(下一页请求需要的url)
    NSString *newUrl = [NSString stringWithFormat:@"%@%@%@",previousUrl,self.np,@"-20.json"];
    
    //开始请求数据
    [manager GET:newUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *temp = [XHTalkModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.dataArray addObjectsFromArray:temp];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    myContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //设置cell样式为无，点击不变灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    [cell.showComment addTarget:self action:@selector(showCommentView:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightAlertBtn addTarget:self action:@selector(rightAlertClick) forControlEvents:UIControlEventTouchUpInside];
    cell.talkModel = self.dataArray[indexPath.row];
    return cell;
}

//更多和举报点击事件
- (void)rightAlertClick {
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *collect = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCtr addAction:collect];
    [alertCtr addAction:report];
    [alertCtr addAction:cancel];
    [self presentViewController:alertCtr animated:YES completion:nil];
}

//评论点击事件
- (void)showCommentView:(myContentCell *)cell {
    XHCommentViewController *comment = [[XHCommentViewController alloc] init];
    comment.talkModel = _dataArray[cell.tag];
    comment.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:comment animated:YES];
}

//根据内容计算行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHTalkModel *talkModel1 = _dataArray[indexPath.row];
    return talkModel1.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHCommentViewController *commentView = [[XHCommentViewController alloc]init];
    commentView.talkModel = _dataArray[indexPath.row];
    commentView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentView animated:YES];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
