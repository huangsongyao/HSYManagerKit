//
//  UIImageView+ZoomScale.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ZoomScale)

/**
 根据scales的宽高比，以及显示宽度widths，动态计算出显示的高度heights

 @param widths 显示宽度widths
 @param scales 宽高比
 */
- (void)hsy_zoomScaleWidths:(CGFloat)widths scales:(CGSize)scales;
+ (CGFloat)hsy_zoomScaleWidths:(CGFloat)widths scales:(CGSize)scales;

/**
 根据scales的宽高比，以及显示宽度heights，动态计算出显示的高度widths
 
 @param heights 显示宽度heights
 @param scales 宽高比
 */
- (void)hsy_zoomScaleHeights:(CGFloat)heights scales:(CGSize)scales;
+ (CGFloat)hsy_zoomScaleHeights:(CGFloat)heights scales:(CGSize)scales;

@end

NS_ASSUME_NONNULL_END
