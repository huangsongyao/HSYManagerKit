//
//  UIViewController+Controller.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "UIViewController+Controller.h"
#import "UIApplication+AppDelegates.h"

@implementation UIViewController (Controller)

#pragma mark - Finder Device Screen ViewController

+ (UIViewController *)hsy_currentViewController
{
    UIViewController *rootViewController = [self.class hsy_rootCurrentViewController];
    UIViewController *currentViewController = [self.class hsy_finderBestViewController:rootViewController];
    return currentViewController;
}

+ (UIViewController *)hsy_finderBestViewController:(UIViewController *)viewController
{
    if (viewController.presentedViewController) {
        return [self.class hsy_finderBestViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController *)viewController;
        if (svc.viewControllers.count > 0) {
            return [self.class hsy_finderBestViewController:svc.viewControllers.lastObject];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *svc = (UINavigationController *)viewController;
        if (svc.viewControllers.count > 0) {
            return [self.class hsy_finderBestViewController:svc.topViewController];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *svc = (UITabBarController *)viewController;
        if (svc.viewControllers.count > 0) {
            return [self.class hsy_finderBestViewController:svc.selectedViewController];
        } else {
            return viewController;
        }
    } else {
        return viewController;
    }
}

+ (UIViewController *)hsy_rootCurrentViewController
{
    UIViewController *rootCurrentViewController = nil;
    UIWindow *window = UIApplication.hsy_keyWindows;
    if(window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0) {
        UIView *frontView = viewsArray.firstObject;
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            rootCurrentViewController = nextResponder;
        } else {
            rootCurrentViewController = window.rootViewController;
        }
    }
    return rootCurrentViewController;
}

@end
