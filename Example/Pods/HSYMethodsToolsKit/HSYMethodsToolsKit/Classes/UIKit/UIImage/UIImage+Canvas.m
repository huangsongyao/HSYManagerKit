//
//  UIImage+Canvas.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "UIImage+Canvas.h"
#import "UIView+Frame.h"

@implementation UIImage (Canvas)

#pragma mark - Draw

static UIImage *createImageWithColor(UIColor *color, CGRect rect)
{
    UIGraphicsBeginImageContext(rect.size);//规定一个画布size
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);//画出一个image
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();//获取新的image
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)hsy_imageWithFillColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIImage *image = [UIImage hsy_imageWithFillColor:color rect:rect];
    
    return image;
}

+ (UIImage *)hsy_imageWithFillColor:(UIColor *)color rect:(CGRect)rect
{
    UIImage *image = createImageWithColor(color, rect);
    return image;
}

#pragma mark - Cut

- (UIImage *)hsy_cutOriginImage:(CGSize)size
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointZero;
    
    if (!CGSizeEqualToSize(self.size, size)) {
        CGFloat widthFactor = (targetWidth / width);
        CGFloat heightFactor = (targetHeight / height);
        if (widthFactor < heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        scaledWidth = (width * scaleFactor);
        scaledHeight = (height * scaleFactor);
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)hsy_captureImageInView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - Combination

- (UIImage *)hsy_combinationOriginImage:(UIColor *)backgroundColor
{
    UIImage *backgroundImageView = [UIImage hsy_imageWithFillColor:backgroundColor rect:(CGRect){CGPointZero, self.size}];
    
    UIGraphicsBeginImageContext(self.size);
    [backgroundImageView drawInRect:(CGRect){CGPointZero, self.size}]; 
    [self drawInRect:(CGRect){CGPointZero, self.size}];
    UIImage *combinationImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return combinationImage;
}

#pragma mark - Draws

+ (UIImage *)hsy_imageWithQRCodeSize:(CGFloat)size withCIImage:(CIImage *)ciImage
{
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceGray();
    
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, spaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *content = [CIContext contextWithOptions:nil];
    CGImageRef bitmapRef = [content createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, bitmapRef);
    
    CGImageRef resultImageRef = CGBitmapContextCreateImage(contextRef);
    CGContextRelease(contextRef);
    CGImageRelease(bitmapRef);
    
    UIImage *image = [UIImage imageWithCGImage:resultImageRef];
    return image;
}


@end
