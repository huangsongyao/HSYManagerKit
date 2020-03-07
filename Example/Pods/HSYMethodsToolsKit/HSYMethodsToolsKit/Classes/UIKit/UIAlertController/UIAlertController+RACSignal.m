//
//  UIAlertController+RACSignal.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/15.
//

#import "UIAlertController+RACSignal.h"
#import "UIView+Frame.h"
#import "NSObject+Property.h"

static NSString *kHSYMethodsToolsKitAlertActionIndexPropertyForKey  = @"HSYMethodsToolsKitAlertActionIndexPropertyForKey";

@implementation UIAlertAction (Index)

- (NSNumber *)hsy_actionIndex
{
    return [self hsy_getPropertyForKey:kHSYMethodsToolsKitAlertActionIndexPropertyForKey];
}

- (void)setHsy_actionIndex:(NSNumber *)hsy_actionIndex
{
    [self hsy_setProperty:hsy_actionIndex forKey:kHSYMethodsToolsKitAlertActionIndexPropertyForKey objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyNonatomicStrong];
}

@end

//************************************************************************************************************************************************************************************

@implementation UIAlertController (RACSignal)

#pragma mark - Controller

+ (NSMutableArray *)hsy_actions:(NSArray<NSString *> *)alertActionTitles
{
    NSMutableArray *alertActions = [NSMutableArray arrayWithCapacity:alertActionTitles.count];
    for (NSString *string in alertActionTitles) {
        [alertActions addObject:@{[string mutableCopy] : @([alertActionTitles indexOfObject:string] == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault)}];
    }
    return alertActions;
}

+ (UIAlertController *)hsy_alertController:(nullable NSString *)title
                                   message:(nullable NSString *)message
                              alertActions:(NSArray<NSDictionary *> *)alertActions
                            preferredStyle:(UIAlertControllerStyle)preferredStyle
                             forSubscriber:(id<RACSubscriber>)subscriber
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:preferredStyle];
    for (NSDictionary *dic in alertActions) {
        NSString *title = dic.allKeys.firstObject;
        UIAlertActionStyle style = (UIAlertActionStyle)[dic.allValues.firstObject integerValue];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            [RACSignal hsy_performSendSignal:subscriber forObject:action];
        }];
        action.hsy_actionIndex = @([alertActions indexOfObject:dic]);
        [alertController addAction:action];
    }
    return alertController;
}

#pragma mark - Alert

+ (RACSignal<UIAlertAction *> *)hsy_showAlertController:(UIViewController *)viewController
                                                  title:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                           alertActions:(NSArray<NSDictionary *> *)alertActions
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        UIAlertController *alertController = [self.class hsy_alertController:title
                                                                     message:message
                                                                alertActions:alertActions
                                                              preferredStyle:UIAlertControllerStyleAlert
                                                               forSubscriber:subscriber];
        [viewController presentViewController:alertController animated:YES completion:^{}];
    }];
}


+ (RACSignal<UIAlertAction *> *)hsy_showAlertController:(UIViewController *)viewController
                                                  title:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      alertActionTitles:(NSArray<NSString *> *)alertActionTitles
{
    NSMutableArray *alertActions = [UIAlertController hsy_actions:alertActionTitles];
    return [self.class hsy_showAlertController:viewController
                                         title:title
                                       message:message
                                  alertActions:alertActions];
}

#pragma mark - Sheet

+ (RACSignal<UIAlertAction *> *)hsy_showSheetController:(UIViewController *)viewController
                                                  title:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                           sheetActions:(NSArray<NSDictionary *> *)sheetActions
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        UIAlertController *sheetController = [self.class hsy_alertController:title
                                                                     message:message
                                                                alertActions:sheetActions
                                                              preferredStyle:UIAlertControllerStyleActionSheet
                                                               forSubscriber:subscriber];
        sheetController.preferredContentSize = viewController.view.size;
        [viewController presentViewController:sheetController animated:YES completion:^{}];
    }];
}

+ (RACSignal<UIAlertAction *> *)hsy_showSheetController:(UIViewController *)viewController
                                                  title:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles
{
    NSMutableArray *alertActions = [UIAlertController hsy_actions:sheetActionTitles];
    return [self.class hsy_showSheetController:viewController
                                         title:title
                                       message:message
                                  sheetActions:alertActions];
}


@end
