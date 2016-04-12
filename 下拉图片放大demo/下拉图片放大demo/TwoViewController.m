//
//  TwoViewController.m
//  下拉图片放大demo
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TwoViewController.h"
#import "UIImageView+YYWebImage.h"
//OC语法糖
#import "HMObjcSugar.h"


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
//HeaderView
- (void)prepareHeaderView {
    //创建一个视图
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, HEADERHEIGHT)];
    headView.backgroundColor = [UIColor hm_colorWithHex:0xF8F8F8];
    [self.view addSubview:headView];
    //创建图片视图
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:headView.bounds];
    imageView.backgroundColor = [UIColor hm_colorWithHex:0x000033];
    [headView addSubview:imageView];
}
//修改状态栏的状态 浅色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
