//
//  UIView+Layer.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Layer)

/**
 根据宽高自动设置圆形的圆角角度，如果width>height，则以高度为圆角切割依据；如果height>width，则以宽度为圆角切割依据；
 */
- (void)hsy_setRoundnessCornerRadius;

@end

NS_ASSUME_NONNULL_END
