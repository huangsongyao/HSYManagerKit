//
//  UINavigationBar+Background.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Background)

/**
 设置UINavigationBar对象的背景图

 @param backgroundImage 背景图
 */
- (void)hsy_setNavigationBarBackgroundImage:(UIImage *)backgroundImage;

/**
 设置UINavigationBar对象的底部横线颜色

 @param color 底部横线颜色
 */
- (void)hsy_setNavigationBarBottomlineColor:(UIColor *)color;

/**
 隐藏UINavigationBar对象底部横线
 */
- (void)hsy_clearNavigationBarBottomline;

@end

NS_ASSUME_NONNULL_END
