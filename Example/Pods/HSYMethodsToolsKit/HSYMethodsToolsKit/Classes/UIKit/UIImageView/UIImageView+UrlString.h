//
//  UIImageView+UrlString.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (UrlString)

/**
 sd请求图片远端地址，无回调，默认占位图为：image_placeholder
 
 @param urlString 图片远端地址
 */
- (void)hsy_setImageWithUrlString:(NSString *)urlString;

/**
 sd请求图片远端地址，无回调
 
 @param urlString 图片远端地址
 @param placeholderImage 默认占位图
 */
- (void)hsy_setImageWithUrlString:(NSString *)urlString placeholderImage:(nullable UIImage *)placeholderImage;

@end

NS_ASSUME_NONNULL_END
