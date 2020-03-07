//
//  UIApplication+AppDelegates.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (AppDelegates)

/**
 *  获取windows层
 *
 *  @return window层
 */
+ (UIWindow *)hsy_keyWindows;

/**
 设备statusBar的size
 
 @return statusBar的size
 */
+ (CGSize)hsy_iPhoneStatusBarSize;

/**
 *  设备statusBar的高度
 *
 *  @return 高度
 */
+ (CGFloat)hsy_statusBarHeight;

/**
 获取AppDelegate
 
 @return AppDelegate
 */
+ (id<UIApplicationDelegate>)hsy_appDelegate;

/**
 获取设备的Screen Bounds
 
 @return 设备的Screen Bounds
 */
+ (CGRect)hsy_iPhoneScreenBounds;

/**
 获取UINavigationBar的视觉高度

 @return UINavigationBar的视觉高度
 */
+ (CGFloat)hsy_navigationBarHeights;

@end

NS_ASSUME_NONNULL_END
