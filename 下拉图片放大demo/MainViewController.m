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
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"推出" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
}
- (void)next {

    [self.navigationController pushViewController:[[TwoViewController alloc]init] animated:YES];
    

    
}



@end
