//
//  NSBundle+PrivateFileResource.h
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (PrivateFileResource)

/**
 专门加载私有库资源图片文件，默认从本SDK中加载
 
 @param imageName 图片文件名称
 @return 图片转化为的UIImage对象
 */
+ (UIImage *)hsy_imageForBundle:(NSString *)imageName;

/**
 专门加载私有库资源图片文件，从本SDK的forBundleName的Bundle文件中加载

 @param imageName 图片文件名称
 @param bundleName 本SDK中引用的Bundle包包名
 @return 图片转化为的UIImage对象
 */
+ (UIImage *)hsy_imageForBundle:(NSString *)imageName forBundleName:(nullable NSString *)bundleName;

/**
 根据CFBundleName作为可以寻址，寻找本SDK中的NSBundle包内的资源文件
 
 @return NSBundle
 */
+ (NSBundle *)hsy_resourceBundle;

/**
 根据CFBundleName作为可以寻址，寻找本SDK中的NSBundle包内的资源文件，默认从thisBundleName包中寻找

 @param thisBundleName 本SDK中引用的Bundle包包名
 @return NSBundle
 */
+ (NSBundle *)hsy_resourceBundle:(nullable NSString *)thisBundleName;

@end

NS_ASSUME_NONNULL_END
