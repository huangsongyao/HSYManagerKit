//
//  UIImage+Formatter.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Formatter)

/**
 JPG转PNG
 
 @return PNG格式图片
 */
- (UIImage *)hsy_toPNG;

/**
 PNG转JPEG
 
 @return JPEG格式图片
 */
- (UIImage *)hsy_toJPEG;


@end

NS_ASSUME_NONNULL_END
