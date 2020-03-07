//
//  UIApplication+OpenURL.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "UIApplication+OpenURL.h"
#import <SafariServices/SafariServices.h>
#import "HSYToolsMacro.h"
#import "UIApplication+AppDelegates.h"
#import "HSYToolsMacro.h"

@implementation UIApplication (OpenURL)

+ (BOOL)hsy_developerOpenURL:(NSURL *)url
{
    BOOL open = [[UIApplication sharedApplication] canOpenURL:url];
    if (open) {
        BOOL isOver10iOSSystems = (IPHONE_SYSTEM_VERSION > 10.0);
        NSString *urlMethod = @{@(YES) : NSStringFromSelector(@selector(openURL:options:completionHandler:)), @(NO) : NSStringFromSelector(@selector(openURL:))}[@(isOver10iOSSystems)];
        HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([[UIApplication sharedApplication] performSelector:NSSelectorFromString(urlMethod) withObject:url withObject:nil]);
    }
    return open;
}

+ (BOOL)hsy_openSafari:(NSString *)url
{
    return [UIApplication hsy_developerOpenURL:[NSURL URLWithString:url]];
}

+ (void)hsy_openSafariServer:(NSString *)url
{
    if (@available(iOS 9.0, *)) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [[UIApplication hsy_appDelegate].window.rootViewController presentViewController:safariViewController animated:YES completion:^{}];
    }
}

+ (void)hsy_openSystemSetting
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [UIApplication hsy_developerOpenURL:url];
}


@end
