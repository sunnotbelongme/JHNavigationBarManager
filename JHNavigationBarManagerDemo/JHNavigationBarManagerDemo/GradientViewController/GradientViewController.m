//
//  GradientViewController.m
//  JHNavigationBarManagerDemo
//
//  Created by 蒋华军 on 16/12/27.
//  Copyright © 2016年 499080255@qq.com. All rights reserved.
//

#import "GradientViewController.h"
#import "JHNavigationBarManager.h"
#import <WebKit/WebKit.h>
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface GradientViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_gradientTableView;
    UIImageView *_headerView;
    UIImageView *  _barImageView;
}

@end

@implementation GradientViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
////        self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
//    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    _barImageView.alpha = 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
//    NSLog(@"%lf",_barImageView.alpha);
    [self createUI];
    [self initBarManager];
    
    // Do any additional setup after loading the view.
}

- (void)initBarManager{
    
//    [JHNavigationBarManager setBarColor:[UIColor clearColor]];
    [JHNavigationBarManager managerWithController:self];
    [JHNavigationBarManager setBarColor:[UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1]];
    [JHNavigationBarManager setTintColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
    [JHNavigationBarManager setStatusBarStyle:UIStatusBarStyleDefault];
    [JHNavigationBarManager setZeroAlphaOffset:0];
    [JHNavigationBarManager setFullAlphaOffset:218 - 64];
    [JHNavigationBarManager setFullAlphaTintColor:[UIColor whiteColor]];
    [JHNavigationBarManager setFullAlphaBarStyle:UIStatusBarStyleLightContent];
//    [JHNavigationBarManager setContinues:NO];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)createUI{
    
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 218)];
    _headerView.image = [UIImage imageNamed:@"back"];
    [self.view addSubview:_headerView];
    _gradientTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 0,[UIScreen mainScreen].bounds.size.width , kScreenHeight) style:UITableViewStylePlain];
    _gradientTableView.showsVerticalScrollIndicator = YES;
    _gradientTableView.delegate = self;
    _gradientTableView.dataSource = self;
    _gradientTableView.backgroundColor = [UIColor clearColor];
//    _gradientTableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gradientTableView];
    
//    _headerView.contentMode = UIViewContentModeScaleAspectFit;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,0 ,kScreenWidth, 218)];
    headView.backgroundColor = [UIColor clearColor];
    _gradientTableView.tableHeaderView = headView;
}

- (void)viewWillDisappear:(BOOL)animated{

    [JHNavigationBarManager reStoreToSystemNavigationBar];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"1111%ld",indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [JHNavigationBarManager changeAlphaWithCurrentOffset:scrollView.contentOffset.y];
    CGFloat y = scrollView.contentOffset.y;
    if (y > 0) {
        
        CGRect rect = _headerView.frame;
        rect.origin.y = - y;
        _headerView.frame = rect;
        
    }else{
        
        CGRect rect = _headerView.frame;
//        rect.origin.y = 0;
        rect.size.height = 218 - y;
        rect.size.width = rect.size.height /  (218 / kScreenWidth);
        rect.origin.x = (kScreenWidth - rect.size.width)/2;
        _headerView.frame = rect;
    }
//    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
//    CGFloat minAlphaOffset = 0;
//    CGFloat maxAlphaOffset = 218;
//    CGFloat offset = scrollView.contentOffset.y;
//    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
//    NSLog(@"%lf",alpha);
//    _barImageView.alpha = alpha;
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
