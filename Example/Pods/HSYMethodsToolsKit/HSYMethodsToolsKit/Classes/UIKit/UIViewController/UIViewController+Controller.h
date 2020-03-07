//
//  UIViewController+Controller.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Controller)

/**
 寻找并返回当前设备在屏幕上所显示的控制器的对象
 
 @return 当前显示于屏幕上的控制器
 */
+ (UIViewController *)hsy_currentViewController;

@end

NS_ASSUME_NONNULL_END
