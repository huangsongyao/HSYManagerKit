//
//  UIImage+Compression.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "UIImage+Compression.h"

@implementation UIImage (Compression)

- (NSData *)hsy_imageCompression:(CGFloat)maxSize
{
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    while ((data.length > maxSize) && (compression > maxCompression)) {
        compression -= maxCompression;
        data = UIImageJPEGRepresentation(self, compression);
    }
    return data;
}

- (UIImage *)hsy_imageCompressionScale:(CGFloat)scale compressionSize:(CGSize)size
{
    UIImage *realImage = nil;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        //压缩图片质量
        CGFloat realScale = scale;
        if (realScale < 0.0f) {
            realScale = 0.0f;
        } else if (scale > 1.0f) {
            scale = 1.0f;
        }
        NSData *data = UIImageJPEGRepresentation(self, realScale);
        realImage = [UIImage imageWithData:data];
    } else {
        //压缩图片尺寸
//        realImage = [self cutOriginImage:size];
    }
    return realImage;
}

- (UIImage *)hsy_imageCompressionSize:(CGSize)size
{
    return [self hsy_imageCompressionScale:0.0f compressionSize:size];
}

- (UIImage *)hsy_imageCompressionScale:(CGFloat)scale
{
    return [self hsy_imageCompressionScale:scale compressionSize:CGSizeZero];
}

@end
