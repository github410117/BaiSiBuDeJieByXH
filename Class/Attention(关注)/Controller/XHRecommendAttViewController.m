//
//  XHRecommendAttViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHRecommendAttViewController.h"
#import "XHLeftTabModel.h"
#import "XHLeftTabCell.h"
#import "XHRightUserCell.h"
#import "XHRightUserModel.h"


static NSString *const leftIdentifier = @"leftcell";
static NSString *const rightIdentifier = @"rightcell";

static NSString *const urlAPI = @"http://api.budejie.com/api/api_open.php";

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
    //初始化tab
    [self setTableView];
    //设置刷新控件
    [self setRefresh];
    //初始化左边表的类别数据
    [self loadLeftData];
    // Do any additional setup after loading the view from its nib.
}



//初始化TabView
- (void)setTableView {
    self.navigationItem.title = @"推荐关注";
    
    _leftTab.dataSource = self;
    _leftTab.delegate = self;
    _rightTab.dataSource = self;
    _rightTab.delegate = self;
    
    //取消2个Tableview的分栏线
    _leftTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //用户表的高度
    _rightTab.rowHeight = 60;
    
    //注册cell
    [_leftTab registerNib:[UINib nibWithNibName:NSStringFromClass([XHLeftTabCell class]) bundle:nil] forCellReuseIdentifier:leftIdentifier];
    [_rightTab registerNib:[UINib nibWithNibName:NSStringFromClass([XHRightUserCell class]) bundle:nil] forCellReuseIdentifier:rightIdentifier];
    
    //设置tableview从导航栏下开始
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置背景颜色
    _leftTab.backgroundColor = RGB(244, 244, 244);
    _rightTab.backgroundColor = RGB(244, 244, 244);
}




- (void)loadLeftData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _leftTabArray = [XHLeftTabModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [_leftTab reloadData];
        
        //默认选种首行,注意要刷新了表格才能设置默认选择
        [_leftTab selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让右边的表开始刷新
        [_rightTab.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"刷新数据失败"];
    }];
    
}


//设置刷新控件
- (void)setRefresh {
    self.rightTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
}


//下拉刷新数据
- (void)downRefresh {
    //取出当前选中的按钮对应的模型
    XHLeftTabModel *leftModel = _leftTabArray[_leftTab.indexPathForSelectedRow.row];
    
    //设置当前页数
    leftModel.currentPage = 1;
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(leftModel.ID);
    params[@"page"] = @(leftModel.currentPage);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *temp = [XHRightUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新前先删除旧数据
        [leftModel.users removeAllObjects];
        
        [leftModel.users addObjectsFromArray:temp];
        
        [self.rightTab reloadData];
        
        [self.rightTab.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.rightTab.mj_header endRefreshing];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - dataSource的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTab) {
        return _leftTabArray.count;
    }
    return [_leftTabArray[_leftTab.indexPathForSelectedRow.row] users].count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTab) {
        XHLeftTabCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier];
        cell.leftTabModel = _leftTabArray[indexPath.row];
        return cell;
    }else {
        XHRightUserCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIdentifier];
        cell.rightUsreModel = [_leftTabArray[_leftTab.indexPathForSelectedRow.row] users][indexPath.row];
        return cell;
    }
}


//选中按钮
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 结束刷新
    [self.rightTab.mj_header endRefreshing];
    
    [_rightTab reloadData]; 
    if (![_leftTabArray[_leftTab.indexPathForSelectedRow.row] users].count) {
        [self.rightTab.mj_header beginRefreshing];
    }
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
