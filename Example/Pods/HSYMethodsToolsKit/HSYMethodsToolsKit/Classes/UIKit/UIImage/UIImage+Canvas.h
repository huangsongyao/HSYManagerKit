//
//  UIImage+Canvas.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Canvas)

/**
 创建不定区域的图片
 
 @param color 图片颜色
 @return UIImage
 */
+ (UIImage *)hsy_imageWithFillColor:(UIColor *)color;

/**
 创建rect区域的图片
 
 @param color 图片颜色
 @param rect 图片区域
 @return UIImage
 */
+ (UIImage *)hsy_imageWithFillColor:(UIColor *)color rect:(CGRect)rect;

/**
 在原图的基础上裁剪一张指定尺寸的新图，保证图片不会因为压缩而变形，超出部分则使用透明填充色
 
 @param size 新图片的尺寸
 @return 指定尺寸的新图
 */
- (UIImage *)hsy_cutOriginImage:(CGSize)size NS_AVAILABLE_IOS(8_0);

/**
 根据给定的背景色，绘制一张作为背景的图片，并将这张背景图和本身图片重叠组成新的带背景图的图片
 
 @param backgroundColor 背景的图片的颜色
 @return 重叠组成新的带背景图的图片
 */
- (UIImage *)hsy_combinationOriginImage:(UIColor *)backgroundColor NS_AVAILABLE_IOS(8_0);

/**
 CIImage转UIImage

 @param size 绘制的UIImage的原始size
 @param ciImage CIImage
 @return 绘制新的UIImage
 */
+ (UIImage *)hsy_imageWithQRCodeSize:(CGFloat)size withCIImage:(CIImage *)ciImage;

@end

NS_ASSUME_NONNULL_END
