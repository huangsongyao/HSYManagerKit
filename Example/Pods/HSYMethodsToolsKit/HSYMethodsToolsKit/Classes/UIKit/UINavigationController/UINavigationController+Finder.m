//
//  UINavigationController+Finder.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "UINavigationController+Finder.h"

@implementation UINavigationController (Finder)

- (void)hsy_popViewControllerClassName:(NSString *)className
{
    [self hsy_popViewControllerClassName:className animated:YES];
}

- (void)hsy_popViewControllerClassName:(NSString *)className animated:(BOOL)animated
{
    UIViewController *viewController = [self hsy_finderViewController:className];
    if (viewController) {
        [self popToViewController:viewController animated:animated];
    }
}

- (BOOL)hsy_canFinderViewController:(NSString *)viewControllerName
{
    UIViewController *viewController = [self hsy_finderViewController:viewControllerName];
    if (viewController) {
        return YES;
    }
    return NO;
}

- (UIViewController *)hsy_finderViewController:(NSString *)viewControllerName
{
    for (UIViewController *viewController in self.viewControllers) {
        if ([NSStringFromClass(viewController.class) isEqualToString:viewControllerName]) {
            return viewController;
        }
    }
    return nil;
}

- (NSArray<NSString *> *)hsy_viewControllerClasses
{
    NSMutableArray *viewControllerClasses = [[NSMutableArray alloc] init];
    for (UIViewController *viewController in self.viewControllers) {
        [viewControllerClasses addObject:NSStringFromClass(viewController.class)];
    }
    return viewControllerClasses.mutableCopy;
}


@end
