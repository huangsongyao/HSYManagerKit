//
//  UIResponder+Orientation.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "UIResponder+Orientation.h"
#import "NSObject+Property.h"

static NSString *kHSYCocoaKitInterfaceOrientationKey    = @"HSYCocoaKitInterfaceOrientationKey";
static NSString *kHSYCocoaKitLandscapeDirectionKey      = @"kHSYCocoaKitLandscapeDirectionKey";

@implementation UIResponder (Orientation)

#pragma mark - Runtime For Property

- (NSNumber *)hsy_landscapeInterfaceOrientation
{
    NSNumber *landscapeInterfaceOrientation = [self hsy_getPropertyForKey:kHSYCocoaKitInterfaceOrientationKey];
    return landscapeInterfaceOrientation;
}

- (void)setHsy_landscapeInterfaceOrientation:(NSNumber *)hsy_landscapeInterfaceOrientation
{
    [self hsy_setProperty:hsy_landscapeInterfaceOrientation
                   forKey:kHSYCocoaKitInterfaceOrientationKey
    objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyNonatomicStrong];
}

- (NSNumber *)hsy_landscapeDirection
{
    NSNumber *direction = [self hsy_getPropertyForKey:kHSYCocoaKitLandscapeDirectionKey];
    return direction;
}

- (void)setHsy_landscapeDirection:(NSNumber *)hsy_landscapeDirection
{
    [self hsy_setProperty:hsy_landscapeDirection
                   forKey:kHSYCocoaKitLandscapeDirectionKey
    objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyNonatomicStrong];
}

#pragma mark - Methods

+ (void)hsy_interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)hsy_landscapeDirection:(BOOL)landscape
{
    UIInterfaceOrientation interfaceOrientation = UIInterfaceOrientationPortrait;
    if (landscape) {
        interfaceOrientation = UIInterfaceOrientationLandscapeRight;
    }
    NSDictionary *dic = @{@(UIInterfaceOrientationPortrait) : @(UIInterfaceOrientationMaskPortrait), @(UIInterfaceOrientationLandscapeRight) : @(UIInterfaceOrientationMaskLandscapeRight), };
    UIInterfaceOrientationMask interfaceOrientationMask = [dic[@(interfaceOrientation)] integerValue];
    self.hsy_landscapeDirection = @(interfaceOrientationMask);
    [UIResponder hsy_interfaceOrientation:interfaceOrientation];
}

@end
