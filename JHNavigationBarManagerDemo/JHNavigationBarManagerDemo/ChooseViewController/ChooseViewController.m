//
//  ChooseViewController.m
//  JHNavigationBarManagerDemo
//
//  Created by 蒋华军 on 16/12/27.
//  Copyright © 2016年 499080255@qq.com. All rights reserved.
//

#import "ChooseViewController.h"
#import "GradientViewController.h"
@interface ChooseViewController ()

@end

@implementation ChooseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    // Do any additional setup after loading the view.
}


- (void)createUI{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(goToNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)goToNext{
    
    GradientViewController *gradientVC = [[GradientViewController alloc] init];
    gradientVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gradientVC animated:YES];
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
