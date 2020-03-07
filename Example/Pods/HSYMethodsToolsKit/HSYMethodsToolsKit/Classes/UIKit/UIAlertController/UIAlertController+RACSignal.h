//
//  UIAlertController+RACSignal.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/15.
//

#import <UIKit/UIKit.h>
#import "RACSignal+Convenients.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertAction (Index)

//配合UIAlertController返回选中的action所在的index
@property (nonatomic, strong) NSNumber *hsy_actionIndex; 

@end

@class RACSignal;
@interface UIAlertController (RACSignal)

/**
 iOS8系统后的alertView

 @param viewController 添加到的控制器层
 @param title title
 @param message message
 @param alertActionTitles 按钮title集合
 @return 回调事件
 */
+ (RACSignal<UIAlertAction *> *)hsy_showAlertController:(UIViewController *)viewController
                                                  title:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      alertActionTitles:(NSArray<NSString *> *)alertActionTitles NS_AVAILABLE_IOS(8_0);

/**
 iOS8系统后的sheetView
 
 @param viewController 添加到的控制器层
 @param title title
 @param message message
 @param sheetActionTitles 按钮title集合
 @return 回调事件
 */

+ (RACSignal<UIAlertAction *> *)hsy_showSheetController:(UIViewController *)viewController
                                                  title:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END
