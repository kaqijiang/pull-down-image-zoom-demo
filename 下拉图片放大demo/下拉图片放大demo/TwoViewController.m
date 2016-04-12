//
//  TwoViewController.m
//  下拉图片放大demo
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TwoViewController.h"
#import "UIImageView+YYWebImage.h"

NSString *const cellId = @"cellId";
#define HEADERHEIGHT 200
@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置新控制器的背景严格，要不然nav会有显示问题
    self.view.backgroundColor = [UIColor whiteColor];
    //TableView
    [self prepareTableView];
    //HeaderView
    [self prepareHeaderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //取消自动调整滚动视图的间距  UIViewController + Nav 会自动调整tabview的contentinset
    self.automaticallyAdjustsScrollViewInsets = NO;
    //视图将要显示的时候隐藏nav
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
//TableView
- (void)prepareTableView {
    //创建tableview
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //设置数据源和代理
    tableView.delegate = self;
    tableView.dataSource = self;
    //注册tableView
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:tableView];
    //设置tableView的contentInset
    tableView.contentInset = UIEdgeInsetsMake(HEADERHEIGHT, 0, 0, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(HEADERHEIGHT, 0, 0, 0);
}
//HeaderView
- (void)prepareHeaderView {
    //创建一个视图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, HEADERHEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    
}
//修改状态栏的状态 浅色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark- TableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}
@end
