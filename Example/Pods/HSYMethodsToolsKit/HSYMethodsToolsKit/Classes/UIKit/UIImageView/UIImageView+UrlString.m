//
//  UIImageView+UrlString.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "UIImageView+UrlString.h"
#import "ReactiveObjC.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "NSBundle+PrivateFileResource.h"
#import "HSYToolsMacro.h"

@implementation UIImageView (UrlString)

- (void)hsy_setImageWithUrlString:(NSString *)urlString
{
    [self hsy_setImageWithUrlString:urlString placeholderImage:nil];
}

- (void)hsy_setImageWithUrlString:(NSString *)urlString placeholderImage:(nullable UIImage *)placeholderImage 
{
    [self hsy_setImageWithUrlString:urlString placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"\n 本次请求的远端图片url地址为：%@", imageURL);
    }];
}

- (void)hsy_setImageWithUrlString:(NSString *)urlString
                 placeholderImage:(UIImage *)placeholderImage
                        completed:(SDExternalCompletionBlock)completed
{
    UIImage *realPlaceholderImage = placeholderImage;
    if (!realPlaceholderImage) {
        realPlaceholderImage = [NSBundle hsy_imageForBundle:@"image_placeholder"];
    }
    if (![urlString hasPrefix:@"http"]) {
        //如果请求链接不是以http开头的远程地址，则尝试拆分，看看链接是否为本地图片资源地址
        NSLog(@"\n warning! --> 图片请求地址不是完整的url链接，将尝试将该链接视为file path，urlString为：%@", urlString);
        NSArray *urls = [urlString componentsSeparatedByString:@"."];
        if (urls.count > 0) {
            NSArray *suffixs = @[
                                 @"png",
                                 @"jpg",
                                 @"gif",
                                 ];
            if ([suffixs containsObject:urls.lastObject]) {
                UIImage *image = [UIImage imageWithContentsOfFile:urlString];
                if (!image) {
                    image = realPlaceholderImage;
                }
                self.image = image;
                self.highlightedImage = image;
                return;
            }
        } else {
            self.image = realPlaceholderImage;
            self.highlightedImage = realPlaceholderImage;
            return;
        }
    }
    @weakify(self);
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:realPlaceholderImage
                     options:SDWebImageRetryFailed
                   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                       @strongify(self);
                       [self hsy_errorWithError:error
                                      withImage:image
                               placeholderImage:realPlaceholderImage];
                       if (completed) {
                           completed(image, error, cacheType, imageURL);
                       }
    }];
}

- (void)hsy_errorWithError:(NSError *)error
                 withImage:(UIImage *)image
          placeholderImage:(UIImage *)placeholderImage
{
    if (error) {
        NSLog(@"图片请求失败，error = %@, error.code = %ld", error, (long)error.code);
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        if (error.code) {
            self.image = placeholderImage;
            self.highlightedImage = placeholderImage;
        }
    } else {
        //在Runloop中执行设置加载成功后的网络图片，避免加载网络大图时，出现卡顿
        [self performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    }
}


@end
