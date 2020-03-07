//
//  UIImage+Formatter.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "UIImage+Formatter.h"

@implementation UIImage (Formatter)

- (UIImage *)hsy_toPNG
{
    NSData *data = UIImagePNGRepresentation(self);
    UIImage *imagePNG = [UIImage imageWithData:data];
    return imagePNG;
}

- (UIImage *)hsy_toJPEG
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    UIImage *imageJPEG = [UIImage imageWithData:data];
    return imageJPEG;
}

@end
