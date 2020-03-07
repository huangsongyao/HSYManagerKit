//
//  UIButton+Loading.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/12/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RACSignal;
@interface UIButton (Loading)

/**
 UIButton的按钮过度效果，大致过程为: 按下按钮=>执行动画=>动画内容为将按钮适配高度和宽度动态放缩=>显示UIActivityIndicatorView效果的loading

 @param maskColor 隔层遮罩的背景色
 @param map map高阶函数，外部返回一个RACSignal，告知函数内部，什么时候去除隔层及loading效果，同时还原UIButton的原始状态
 */
- (void)hsy_loadingButton:(UIColor *)maskColor forMap:(RACSignal *(^)(BOOL isAnimating))map;

/// UIButton的按钮过度效果，大致过程为: 按下按钮=>执行动画=>动画内容为将按钮适配高度和宽度动态放缩=>显示UIActivityIndicatorView效果的loading
/// @param maskColor 隔层遮罩的背景色
/// @param map map高阶函数，外部返回一个RACSignal，告知函数内部，什么时候去除隔层及loading效果，同时还原UIButton的原始状态
/// @param reset 从loading状态重置回正常的状态后的回调通知
- (void)hsy_loadingButton:(UIColor *)maskColor forMap:(RACSignal *(^)(BOOL isAnimating))map resetStateFinished:(void(^)(UIButton *button))reset;

@end 

NS_ASSUME_NONNULL_END
