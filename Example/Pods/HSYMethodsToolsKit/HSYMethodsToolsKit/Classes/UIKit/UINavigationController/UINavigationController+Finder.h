//
//  UINavigationController+Finder.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Finder)

/**
 pop至指定className的页面，默认携带动画

 @param className 指定页面的类名
 */
- (void)hsy_popViewControllerClassName:(NSString *)className;

/**
 pop至指定className的页面

 @param className 指定页面的类名
 @param animated 是否执行动画
 */
- (void)hsy_popViewControllerClassName:(NSString *)className animated:(BOOL)animated;

/**
 判断指定的className页面是否存在栈控制器当中

 @param viewControllerName 指定页面的类名
 @return 是否存在站栈制器当中
 */
- (BOOL)hsy_canFinderViewController:(NSString *)viewControllerName;

/**
 判断指定的className页面，返回栈控制器的这个页面控制器的对象指针，如果不存在则返回nil

 @param viewControllerName 指定页面的类名
 @return 返回栈控制器的这个页面控制器的对象指针，如果不存在则返回nil
 */
- (UIViewController *)hsy_finderViewController:(NSString *)viewControllerName;

/**
 讲self.viewControllers的栈控制器内的所有的页面控制器的类名

 @return 栈控制器内的所有的页面控制器的类名
 */
- (NSArray<NSString *> *)hsy_viewControllerClasses;

@end

NS_ASSUME_NONNULL_END
