//
//  UIView+Rotated.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import "UIView+Rotated.h"
#import "NSObject+Property.h" 

NSString *const kHSYMethodsToolsViewRotationsForKey       = @"HSYMethodsToolsViewRotationsForKey";
static NSString *kHSYMethodsToolsRotationsCompletedForKey      = @"HSYMethodsToolsRotationsCompletedForKey";

@implementation UIView (Rotated)

#pragma mark - Runtime

- (HSYRotationsCompleted)rotationCompleted
{
    return [self hsy_getPropertyForKey:kHSYMethodsToolsRotationsCompletedForKey];
}

- (void)setRotationCompleted:(HSYRotationsCompleted)rotationCompleted
{
    [self hsy_setProperty:rotationCompleted
                   forKey:kHSYMethodsToolsRotationsCompletedForKey
    objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyNonatomicCopy];
}

#pragma mark - Methods

- (void)hsy_stopRotated
{
    [self.layer removeAnimationForKey:kHSYMethodsToolsViewRotationsForKey];
}

- (void)hsy_rotateds:(NSTimeInterval)duration repeatCount:(NSInteger)repeat forKey:(NSString *)key completed:(HSYRotationsCompleted)completed
{
    if ([self.layer.animationKeys containsObject:kHSYMethodsToolsViewRotationsForKey]) {
        [self hsy_stopRotated];
    }
    if ([self.layer.animationKeys containsObject:key]) {
        [self.layer removeAnimationForKey:key];
    }
    CABasicAnimation *rotateds = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateds.delegate = self;
    rotateds.toValue = @(M_PI * 2.0);
    rotateds.duration = duration;
    rotateds.repeatCount = repeat;
    
    self.rotationCompleted = completed;
    [self.layer addAnimation:rotateds forKey:key];
}

- (void)hsy_rotateds
{
    [self hsy_rotateds:^(CAAnimation *animation) {}];
}

- (void)hsy_rotateds:(HSYRotationsCompleted)completed
{
    [self hsy_rotateds:1.0f completed:completed];
}

- (void)hsy_rotatedsRepeat:(NSInteger)repeat
{
    [self hsy_rotatedsRepeat:repeat completed:^(CAAnimation *animation) {}];
}

- (void)hsy_rotatedsRepeat:(NSInteger)repeat completed:(HSYRotationsCompleted)completed
{
    [self hsy_rotateds:1.0f repeatCount:repeat forKey:kHSYMethodsToolsViewRotationsForKey completed:completed];
}

- (void)hsy_rotateds:(NSTimeInterval)duration completed:(HSYRotationsCompleted)completed
{
    [self hsy_rotateds:duration forKey:kHSYMethodsToolsViewRotationsForKey completed:completed];
}

- (void)hsy_rotateds:(NSTimeInterval)duration forKey:(NSString *)key completed:(HSYRotationsCompleted)completed
{
    [self hsy_rotateds:duration repeatCount:HUGE_VALF forKey:key completed:completed];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.rotationCompleted) {
        self.rotationCompleted(anim);
    }
}

@end
