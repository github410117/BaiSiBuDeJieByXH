//
//  XHScrollBarBaseViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHScrollBarBaseViewController.h"

//定义标识符
static NSString *const identifier = @"cell";

@interface XHScrollBarBaseViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *collection;
}
//滚动条ScrollView
@property (nonatomic, strong) UIScrollView *topScrollView;

//滚动条下的红线
@property (nonatomic, strong) UIView *redLine;

//选中的按钮
@property (nonatomic, strong) UIButton *selectedBtn;

//所有的按钮
@property (nonatomic, copy) NSMutableArray *titleBtns;

//第一次启动
@property (nonatomic, assign) BOOL first;
@end

@implementation XHScrollBarBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:back];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    //设置UIcollection
    [self setCollectionView];
    
    //设置ScrollView
    [self setupTopTitleView];
    
    //关掉自动调整，自己手动来调整布局
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_first == NO) {
        //显示头部标题
        [self setAllTitle];
        
        _first = YES;
    }
    
}

//设置顶部文字标题
- (void)setupTopTitleView
{
    //创建顶部标题，因为标题可以滚动所以用UIScrollView创建
    _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 35)];
    
    //给UIScrollView设置背景图片
    UIImage *image = GetImage(@"navigationbarBackgroundWhite");
    [_topScrollView setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    
    //把ScrollView添加到当前View上
    [self.view addSubview:_topScrollView];
}



- (void)setCollectionView {
    //设置为流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(Main_Screen_Width  ,Main_Screen_Height);
    
    //设置UICollectionView在什么方向可以滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //行间距和item间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) collectionViewLayout:flowLayout];
    
    [self.view addSubview:collection];
    
    //注册
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    //代理
    collection.dataSource = self;
    collection.delegate = self;
    
    //分页
    collection.pagingEnabled = YES;
    
    //取消弹簧效果
    collection.bounces = NO;
    
    //取消滑动效果条
    collection.showsHorizontalScrollIndicator = NO;
    
    //加个背景，不然UIcollection默认背景是黑色，导航栏又是毛玻璃透明效果，就会显的很黑(我也是用Reveal看出来的)
    collection.backgroundColor = [UIColor whiteColor];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(Main_Screen_Width, Main_Screen_Height);
}

#pragma mark - UICollectionView数据源代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //移除以前的子控制器
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //把对应的子控制器取出并设置大小
    UIViewController *ctr = self.childViewControllers[indexPath.row];
    ctr.view.bounds = Main_Screen_Bounds;
    
    //将新的子控制器加到contentView上
    [cell.contentView addSubview:ctr.view];
    return cell;
}

/**
 *  设置title的标题
 */
- (void)setAllTitle {
    //宽度为屏幕宽度/btn的个数
    CGFloat btnW = Main_Screen_Width / _titleBtnCount;
    CGFloat btnH = 35;
    CGFloat btnX;
    CGFloat btnY = 0;
    
    //根据子控制器数量来创建btn
    for (int i = 0; i < self.childViewControllers.count; ++i) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        //根据i取出子控制器，使用子控制器的title(添加子控制器时绑定了title)
        UIViewController *ctr = self.childViewControllers[i];
        [btn setTitle:ctr.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //给btn添加个事件监听
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //将btn加到ScrollView上
        [_topScrollView addSubview:btn];
        
        //默认选择第一个按钮
        if (i == 0) {
            [self btnClick:btn];
            [self redline:btn];
        }
        
        [self.titleBtns addObject:btn];
        
    }
    //设置ScrollView的大小
    _topScrollView.contentSize = CGSizeMake(self.childViewControllers.count * btnW, 0);
    //关闭滑动效果
    _topScrollView.showsHorizontalScrollIndicator = NO;
}

/**
 *  titleBtn的点击事件
 */
- (void)btnClick:(UIButton *)btn {
    NSInteger i = btn.tag;
    
    [self changeBtnState:btn];
    
    //根据点的按钮来算偏移量，偏移collection
    collection.contentOffset = CGPointMake(i * Main_Screen_Width, 0);
}

/**
 *  改变按钮状态，改为selected
 */
- (void)changeBtnState:(UIButton *)btn {
    //设置量进行还原
    _selectedBtn.transform = CGAffineTransformIdentity;
    
    //btn颜色改变
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    //让选中的btn在显示在屏幕正中(是偏移的ScrollView)
    CGFloat offsetX = btn.center.x - Main_Screen_Width * 0.5;
    
    //表明还没有产生偏移量，点的btn还是1/2左边的
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    //最大的偏移量,已经到了最右边超过了1/2,直接设置为最大偏移量
    CGFloat maxOffsetX = _topScrollView.contentSize.width - Main_Screen_Width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    //改变ScrollView偏移量
    [_topScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    //btn的文字缩放
    btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    //改变btn为selected
    _selectedBtn = btn;
    
//    红线滑动(带动画)
    [UIView animateWithDuration:0.25 animations:^{
        _redLine.centerX = btn.centerX;
    }];
    
}

/**
 *  红线
 */
- (void)redline:(UIButton *)btn {
    _redLine = [[UIView alloc] init];
    _redLine.backgroundColor = [UIColor redColor];
    
    _redLine.height = 2;
    
    //btn中的文字自适应
    [btn.titleLabel sizeToFit];
    //因为文字选中后要放大所以红线也得放大
    _redLine.width = btn.titleLabel.width * 1.2;
    _redLine.y = _topScrollView.height - 2;
    _redLine.centerX = btn.centerX;
    //将红线加到ScrollView
    [_topScrollView addSubview:_redLine];
}


#pragma mark - UICollectionView的代理方法(准确来说是ScrollView的代理方法)
/**
 *  UICollection滑动完调用的方法，iphone的本来没这个功能，就是可以左右滑动切换页面
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = scrollView.contentOffset.x / Main_Screen_Width;
    UIButton *btn = _titleBtns[i];
    [self changeBtnState:btn];
}

 
/**
 *  滑动中调用的方法(在滚动中变换btn的文字和颜色)
 */
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //上一个btn
    NSInteger last = scrollView.contentOffset.x / Main_Screen_Width;
    //下一个btn
    NSInteger next = last + 1;
    
    UIButton *lastBtn = _titleBtns[last];
    UIButton *nextBtn = nil;
    
    //防止数组越界，如果点到最后一个，不判断会越界
    if (next < self.titleBtns.count) {
        nextBtn = _titleBtns[next];
    }
    
    //设置文字大小缩放
    lastBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    nextBtn.transform = CGAffineTransformMakeScale(1, 1);
    
    //改变按钮颜色
    [lastBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

*/


/**
 *  懒加载
 */
- (NSMutableArray *)titleBtns {
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
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
