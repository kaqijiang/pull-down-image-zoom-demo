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
#define HEADERHEIGHT 250
@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TwoViewController {
    UIView              *_headView;
    UIImageView         *_headImageView;
    UIStatusBarStyle    _statusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置新控制器的背景严格，要不然nav会有显示问题
    self.view.backgroundColor = [UIColor whiteColor];
    //TableView
    [self prepareTableView];
    //HeaderView
    [self prepareHeaderView];
    //状态栏的颜色
    _statusBarStyle = UIStatusBarStyleLightContent;
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
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, HEADERHEIGHT)];
    _headView.backgroundColor = [UIColor hm_colorWithHex:0xF8F8F8];
    [self.view addSubview:_headView];
    //创建图片视图
    _headImageView = [[UIImageView alloc]initWithFrame:_headView.bounds];
    _headImageView.backgroundColor = [UIColor hm_colorWithHex:0x000033];

    //设置图片大小样式contentMode UIViewContentModeScaleAspectFill等比例
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    //裁减超出部分
    _headImageView.clipsToBounds = YES;
    [_headView addSubview:_headImageView];
    
    
    //设置网络图片 用yy_WebImage 因为 AFN大图不缓存， SDWebImage 没有指示器。
    NSURL *url = [[NSURL alloc]initWithString:@"http://c.hiphotos.baidu.com/zhidao/pic/item/3bf33a87e950352afcc234985243fbf2b3118bfa.jpg"];
    [_headImageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
}
//修改状态栏的状态 浅色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
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

#pragma mark- scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //contentoffset.y 是一个负值    contentInset.top 是一个正值。 符号相反
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    //放大
    if (offset <= 0 ) {
        
        //OC语法糖
        _headView.hm_height = HEADERHEIGHT - offset;//正减负 等于正加正
        _headImageView.hm_height = _headView.hm_height;
        _headImageView.alpha = 1;
    } else {
    //整体移动
        
        _headView.hm_height = HEADERHEIGHT;
        _headImageView.hm_height = _headView.hm_height;
        //Y的最小值，
        CGFloat min = HEADERHEIGHT - 64;
        //移动
        _headView.hm_y = -MIN(min, offset);
        CGFloat progress = 1 - offset / min;
        _headImageView.alpha = progress;
        //判断状态栏颜色
        _statusBarStyle = (progress > 0.5) ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
        //状态栏颜色记得跟新状态
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
        
    }
}
@end
