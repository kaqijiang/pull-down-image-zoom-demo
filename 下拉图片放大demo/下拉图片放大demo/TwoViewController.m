//
//  TwoViewController.m
//  下拉图片放大demo
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TwoViewController.h"

NSString *const cellId = @"cellId";

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
}
//HeaderView
- (void)prepareHeaderView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
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
