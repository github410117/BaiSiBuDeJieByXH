//
//  XHMeViewController.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/6.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHMeViewController.h"

@interface XHMeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *XHTableView;

@end

@interface XHMeViewController ()

@end

@implementation XHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_XHTableView];
    // Do any additional setup after loading the view from its nib.
}




- (void)setTableView {
    
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
