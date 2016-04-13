//
//  MainViewController.m
//  下拉图片放大demo
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainViewController.h"
#import "TwoViewController.h"

@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];

    //设置UIBarButton 并监听
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"推出" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
}
//触发事件
- (void)next {
    //push 控制器
    [self.navigationController pushViewController:[[TwoViewController alloc]init] animated:YES];
}
//视图将要加载的时候
- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


@end
