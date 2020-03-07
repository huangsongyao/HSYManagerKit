//
//  UINavigationBar+NavigationItem.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

CGFloat const kHSYCustomNavigationBarButtonForSize                          = 44.0f;

@interface UINavigationBar (NavigationItem)

/**
 创建image图标格式的NavigationItem集合

 @param paramters 入参，格式为：@[@{@(navigationItem.tag) : @{navigationItem.image.name : navigationItem.hightlightImage.name}}, ... ]
 @param left 偏移量，正数表示向右侧偏移，负数表示向左侧偏移
 @param next 点击事件
 @return NSArray<UIBarButtonItem *> *
 */
+ (NSArray<UIBarButtonItem *> *)hsy_imageNavigationItems:(NSArray<NSDictionary<NSNumber *, NSDictionary *> *> *)paramters
                                          leftEdgeInsets:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建title文字格式的NavigationItem集合

 @param paramters 入参，格式为：@[@{@{@(navigationItem.tag) : navigationItem.font} : @{@"navigationItem.title" : navigationItem.titleColor}}, ....]
 @param left 偏移量，正数表示向右侧偏移，负数表示向左侧偏移
 @param next 点击事件
 @return NSArray<UIBarButtonItem *> *
 */
+ (NSArray<UIBarButtonItem *> *)hsy_titleNavigationItems:(NSArray<NSDictionary<NSDictionary<NSNumber *, UIFont *> *, NSDictionary<NSString *, UIColor *> *> *> *)paramters
                                          leftEdgeInsets:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

@end

NS_ASSUME_NONNULL_END
