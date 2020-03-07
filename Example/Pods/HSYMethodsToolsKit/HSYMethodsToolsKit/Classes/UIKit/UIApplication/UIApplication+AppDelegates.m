//
//  UIApplication+AppDelegates.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "UIApplication+AppDelegates.h"
#import "HSYToolsMacro.h"

@implementation UIApplication (AppDelegates)

+ (UIWindow *)hsy_keyWindows
{
    return [[UIApplication sharedApplication] keyWindow];
}

+ (CGSize)hsy_iPhoneStatusBarSize
{
    return [[UIApplication sharedApplication] statusBarFrame].size;
}

+ (CGFloat)hsy_statusBarHeight
{
    CGFloat height = [UIApplication hsy_iPhoneStatusBarSize].height;
    if (!height) {
        height = (HSY_IS_iPhoneX ? 44.0f : 20.0f);
    }
    return height;
}

+ (id<UIApplicationDelegate>)hsy_appDelegate
{
    return [UIApplication sharedApplication].delegate;
}

+ (CGRect)hsy_iPhoneScreenBounds
{
    return [UIScreen mainScreen].bounds;
}

+ (CGFloat)hsy_navigationBarHeights
{
    return (HSY_IS_iPhoneX ? 88.0f : 64.0f);
}

@end
