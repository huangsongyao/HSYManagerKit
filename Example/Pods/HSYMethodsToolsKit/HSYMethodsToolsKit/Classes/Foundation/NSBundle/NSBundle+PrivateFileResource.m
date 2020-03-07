//
//  NSBundle+PrivateFileResource.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSBundle+PrivateFileResource.h"

@implementation NSBundle (PrivateFileResource)

+ (UIImage *)hsy_imageForBundle:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        return image;
    }
    NSBundle *resourceBundle = [NSBundle hsy_resourceBundle];
    image = [UIImage imageNamed:imageName
                       inBundle:resourceBundle
  compatibleWithTraitCollection:nil];
    
    return image;
}

+ (UIImage *)hsy_imageForBundle:(NSString *)imageName forBundleName:(nullable NSString *)bundleName
{
    NSBundle *resourceBundle = [NSBundle hsy_resourceBundle:bundleName];
    UIImage *image = [UIImage imageNamed:imageName
                                inBundle:resourceBundle
           compatibleWithTraitCollection:nil];
    
    return image;
}

+ (NSBundle *)hsy_resourceBundle
{
    return [NSBundle hsy_resourceBundle:nil];
}

+ (NSBundle *)hsy_resourceBundle:(nullable NSString *)thisBundleName
{
    //通过mainBundle获取到target名称，一般来说，cocoapods工程的target会带有"_Example"后缀，需要过滤掉这个后缀
    NSString *bundleName = [[NSBundle mainBundle].infoDictionary[@"CFBundleName"] componentsSeparatedByString:@"_Example"].firstObject;
    //cocoapods的库的本地路径，"Frameworks" 是.app包中的固定名称的文件夹，mainBundle的绝对路径需要拼接它，最后加上"framework"后缀类型
    NSURL *associateBundleURL = [[[[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil] URLByAppendingPathComponent:bundleName] URLByAppendingPathExtension:@"framework"];
    NSBundle *associateBundle = [NSBundle bundleWithURL:associateBundleURL];
    associateBundleURL = [associateBundle URLForResource:bundleName withExtension:@"bundle"];
    if (thisBundleName.length) {
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", thisBundleName]];
    }
    if (!associateBundleURL) {
        NSString *pluginName = @"HSYUIArchitectureToolsKit";
        NSBundle *realAssociateBundle = [NSBundle bundleWithURL:[[[[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil] URLByAppendingPathComponent:pluginName] URLByAppendingPathComponent:@"framework"]];
        associateBundleURL = [realAssociateBundle URLForResource:pluginName withExtension:@"bundle"];
    }
    
    if (!associateBundleURL) {
        associateBundleURL = [NSURL fileURLWithPath:@"file:///"];
    }
    NSBundle *resourceBundle = [NSBundle bundleWithURL:associateBundleURL];
    
    return resourceBundle;
}

@end
