//
//  JHNavigationBarManager.h
//  JHNavigationBarManagerDemo
//
//  Created by 蒋华军 on 16/12/27.
//  Copyright © 2016年 499080255@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JHNavigationBarManager : NSObject


@property (nonatomic,strong) UIColor *barColor;
@property (nonatomic,strong) UIColor *tintColor;
@property (nonatomic,strong) UIImage *backgroupImage;
@property (nonatomic,assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic,assign) float zeroAlphaOffset;
@property (nonatomic,assign) float fullAlphaOffset;
@property (nonatomic,assign) float minAlphaValue;
@property (nonatomic,assign) float maxAlphavalue;

@property (nonatomic,strong) UIColor *fullAlphaTintColor;
@property (nonatomic,assign) UIStatusBarStyle fullAlphaBarStyle;

@property (nonatomic,assign) BOOL allChange;
@property (nonatomic,assign) BOOL reversal;
@property (nonatomic,assign) BOOL continues;


/**
 设置导航栏背景颜色
 @param color 背景颜色
 */
+ (void)setBarColor:(UIColor *)color;

/**
 设置导航栏字体颜色

 @param color 字体颜色
 */
+ (void)setTintColor:(UIColor *)color;

/**
 设置导航栏背景图片

 @param image 设置背景图片
 */
+ (void)setBackgroundImage:(UIImage *)image;

/**
 设置状态栏类型

 @param style 状态栏类型
 */
+ (void)setStatusBarStyle:(UIStatusBarStyle)style;


/**
 设置从那个点开始变化透明度 默认－64

 @param offset 起始偏移变化的点
 */
+ (void)setZeroAlphaOffset:(float)offset;

/**
 设置最大偏移变化的点 默认200

 @param offset 最大偏移变化的点
 */

+ (void)setFullAlphaOffset:(float)offset;

/**
 设置最大透明度

 @param value 透明度
 */
+ (void)setMaxAlphaValue:(float)value;

/**
 设置最小透明度

 @param value 透明度
 */
+ (void)setMinAlphaValue:(float)value;

/**
 设置最大透明度时字体颜色

 @param color 最大透明度字体颜色
 */
+ (void)setFullAlphaTintColor:(UIColor *)color;

/**
 设置最大透明度时状态栏的类型

 @param style 状态栏的类型
 */
+ (void)setFullAlphaBarStyle:(UIStatusBarStyle)style;


/**
 是否同时改变字体颜色 默认yes

 @param allChange 是否改变字体颜色
 */
+ (void)setAllChange:(BOOL)allChange;

/**
 设置是否反向 默认no 如果设置yes 如果currentAlpha=0.3 他会变成 1 － 0.3 ＝ 0.7

 @param reversal 是否反向
 */
+ (void)setReversal:(BOOL)reversal;

/**
 设置是否一致变化 默认yes 只要滚动就可以变化 如果no只有最大值时候才会变化

 @param continues <#continues description#>
 */
+ (void)setContinues:(BOOL)continues;

/**
 设置当前控制器导航栏

 @param viewController 当前控制器
 */
+ (void)managerWithController:(UIViewController *)viewController;

/**
 通过偏移量改变当前颜色透明度

 @param currentOffset 偏移量
 */
+ (void)changeAlphaWithCurrentOffset:(CGFloat)currentOffset;


/**
 恢复默认状态栏
 */
+ (void)reStoreToSystemNavigationBar;

@end
