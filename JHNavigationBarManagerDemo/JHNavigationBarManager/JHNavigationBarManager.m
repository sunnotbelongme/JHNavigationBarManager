//
//  JHNavigationBarManager.m
//  JHNavigationBarManagerDemo
//
//  Created by 蒋华军 on 16/12/27.
//  Copyright © 2016年 499080255@qq.com. All rights reserved.
//

#import "JHNavigationBarManager.h"
static const CGFloat kNavigationBarHeight = 64.0f;
static const CGFloat kDefalutFullOffset = 200.0f;
static const float   kMaxAlphaValue  = 0.995f;
static const float   kMinAlphaValue = 0.0f;
static const float   kDefaultAnimationTime = 0.35f;
#define SCREEN_RECT [UIScreen mainScreen].bounds
#define BACKGROUNDVIEW_FRAME CGRectMake(0,-20,CGRectGetWidth(SCREEN_RECT),kNavigationBarHeight)
@interface JHNavigationBarManager ()

@property (nonatomic,strong) UINavigationBar *selfNavigationBar;
@property (nonatomic,strong) UINavigationController *selfNavigationController;

@property (nonatomic,strong) UIImage *saveImage;
@property (nonatomic,strong) UIColor *saveColor;
@property (nonatomic,strong) UIColor *saveTintColor;
@property (nonatomic,strong) NSDictionary *saveTitleAttribute;
@property (nonatomic,assign) UIStatusBarStyle saveBarStyle;

@property (nonatomic,assign) BOOL setFull;
@property (nonatomic,assign) BOOL setZero;
@property (nonatomic,assign) BOOL setChange;


@end
@implementation JHNavigationBarManager
#pragma mar - property set

+ (void)setBarColor:(UIColor *)color {
    [self sharedManager].barColor = color;
}

+ (void)setTintColor:(UIColor *)color {
    [self sharedManager].tintColor = color;
    [self sharedManager].selfNavigationBar.tintColor = color;
    [self setTitleColorWithColor:color];
}

+ (void)setBackgroundImage:(UIImage *)image {
    [[self sharedManager].selfNavigationBar setBackgroundImage:image
                                                 forBarMetrics:UIBarMetricsDefault];
}

+ (void)setStatusBarStyle:(UIStatusBarStyle)style {
    [self sharedManager].statusBarStyle = style;
    [[UIApplication sharedApplication] setStatusBarStyle:style];
}

+ (void)setZeroAlphaOffset:(float)offset {
    [self sharedManager].zeroAlphaOffset = offset;
}

+ (void)setFullAlphaOffset:(float)offset {
    [self sharedManager].fullAlphaOffset = offset;
}

+ (void)setMinAlphaValue:(float)value {
    value = value < kMinAlphaValue ? kMinAlphaValue : value;
    [self sharedManager].minAlphaValue = value;
}

+ (void)setMaxAlphaValue:(float)value {
    value = value > kMaxAlphaValue ? kMaxAlphaValue : value;
    [self sharedManager].maxAlphavalue = value;
}

+ (void)setFullAlphaTintColor:(UIColor *)color {
    [self sharedManager].fullAlphaTintColor = color;
}

+ (void)setFullAlphaBarStyle:(UIStatusBarStyle)style {
    [self sharedManager].fullAlphaBarStyle = style;
}

+ (void)setAllChange:(BOOL)allChange {
    [self sharedManager].allChange = allChange;
}

+ (void)setReversal:(BOOL)reversal {
    [self sharedManager].reversal = reversal;
}

+ (void)setContinues:(BOOL)continues {
    [self sharedManager].continues = continues;
}

+ (void)reStoreToSystemNavigationBar {
    [[self sharedManager].selfNavigationController setValue:[UINavigationBar new] forKey:@"navigationBar"];
}

#pragma mark - Pubick Method

+ (void)managerWithController:(UIViewController *)viewController{
    UINavigationBar *navigationBar = viewController.navigationController.navigationBar;
    [self sharedManager].selfNavigationController = viewController.navigationController;
    [self sharedManager].selfNavigationBar = navigationBar;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

+ (void)changeAlphaWithCurrentOffset:(CGFloat)currentOffset{
    JHNavigationBarManager *manager = [self sharedManager];
    float currentAlpha = [self curretAlphaForOffset:currentOffset];
    NSLog(@"%@!!!!!!!!!!!!!!",manager.barColor);
    if (![manager.barColor isEqual:[UIColor clearColor]]) {
        if (!manager.continues) {
            if (currentAlpha == manager.minAlphaValue) {
                [self setNavigationBarColorWithAlpha:manager.minAlphaValue];
            }else if(currentAlpha == manager.maxAlphavalue){
                [UIView animateWithDuration:kDefaultAnimationTime animations:^{
                    [self setNavigationBarColorWithAlpha:manager.maxAlphavalue];
                }];
                manager.setChange = YES;
            }else{
             NSLog(@"进入111");
            if (manager.setChange) {
                [UIView animateWithDuration:kDefaultAnimationTime animations:^{
                    [self setNavigationBarColorWithAlpha:manager.minAlphaValue];
                }];
                manager.setChange = NO;
                }
            }
        }else{
        NSLog(@"进入");
        [self setNavigationBarColorWithAlpha:currentAlpha];
        }
    }
    
    if (manager.allChange) {
        [self changeTintColorWithOffset:currentAlpha];
    }
}

#pragma mark- caluculation
+ (float)curretAlphaForOffset:(CGFloat)offset{
    JHNavigationBarManager *manager = [self sharedManager];
    float currentAlpha = (offset - manager.zeroAlphaOffset) / (float)(manager.fullAlphaOffset - manager.zeroAlphaOffset);
    currentAlpha = currentAlpha < manager.minAlphaValue ? manager.minAlphaValue : (currentAlpha > manager.maxAlphavalue ? manager.maxAlphavalue : currentAlpha);
    currentAlpha = manager.reversal? manager.maxAlphavalue + manager.minAlphaValue - currentAlpha : currentAlpha;
    return currentAlpha;
}

+ (void)changeTintColorWithOffset:(float)currentAlpha{
    
    JHNavigationBarManager *manager = [self sharedManager];
    if (currentAlpha >= manager.maxAlphavalue && manager.fullAlphaTintColor != nil) {
        if (manager.setFull) {
            manager.setFull = NO;
            manager.setZero = YES;
        }else{
            if (manager.reversal) {
                manager.setFull = YES;
            }
            return;
        }
        manager.selfNavigationBar.tintColor = manager.fullAlphaTintColor;
        [self setTitleColorWithColor:manager.fullAlphaTintColor];
        [self setUIStatusBarStyle:manager.fullAlphaBarStyle];
    }else if(manager.tintColor != nil){
        
        if (manager.setZero) {
            manager.setZero = NO;
            manager.setFull = YES;
        }else{
            
            return;
        }
        manager.selfNavigationBar.tintColor = manager.tintColor;
        [self setTitleColorWithColor:manager.tintColor];
        [self setUIStatusBarStyle:manager.statusBarStyle];
    }
}
#pragma mark - private metod
+ (JHNavigationBarManager *)sharedManager{
    static JHNavigationBarManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHNavigationBarManager alloc] init];
        [self initBaseData:manager];
    });
    return manager;
}

+ (void)initBaseData:(JHNavigationBarManager *)manager{
    manager.maxAlphavalue = kMaxAlphaValue;
    manager.minAlphaValue = kMinAlphaValue;
    manager.fullAlphaOffset = kDefalutFullOffset;
    manager.zeroAlphaOffset = -kNavigationBarHeight;
    manager.setZero = YES;
    manager.setFull = YES;
    manager.allChange = YES;
    manager.continues = YES;
}

+ (void)setTitleColorWithColor:(UIColor *)color{
    NSMutableDictionary *textDic = [NSMutableDictionary dictionaryWithDictionary:[self sharedManager].selfNavigationBar.titleTextAttributes];
    [textDic setObject:color forKey:NSForegroundColorAttributeName];
    [self sharedManager].selfNavigationBar.titleTextAttributes = textDic;
}

+ (void)setNavigationBarColorWithAlpha:(float)alpha{
    JHNavigationBarManager *manager = [self sharedManager];
    [self setBackgroundImage:[self imageWithColor:[manager.barColor colorWithAlphaComponent:alpha]]];
}

+ (void)setUIStatusBarStyle:(UIStatusBarStyle)style{
    NSLog(@"变白");
    [[UIApplication sharedApplication] setStatusBarStyle:style];
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}


@end
