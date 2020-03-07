//
//  NSObject+Property.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

+ (objc_AssociationPolicy)toObjcAssociationPolicy:(kHSYMethodsToolsKitObjcAssociationPolicy)associationPolicy
{
    NSDictionary *policys = @{@(kHSYMethodsToolsKitObjcAssociationPolicyAssign) : @(OBJC_ASSOCIATION_ASSIGN),
                              @(kHSYMethodsToolsKitObjcAssociationPolicyNonatomicStrong) : @(OBJC_ASSOCIATION_RETAIN_NONATOMIC),
                              @(kHSYMethodsToolsKitObjcAssociationPolicyNonatomicCopy) : @(OBJC_ASSOCIATION_COPY_NONATOMIC),
                              @(kHSYMethodsToolsKitObjcAssociationPolicyAtomicStrong) : @(OBJC_ASSOCIATION_RETAIN),
                              @(kHSYMethodsToolsKitObjcAssociationPolicyAtomicCopy) : @(OBJC_ASSOCIATION_COPY), };
    objc_AssociationPolicy objcAssociationPolicy = (objc_AssociationPolicy)[policys[@(associationPolicy)] integerValue];
    return objcAssociationPolicy;
} 

- (id)hsy_getPropertyForKey:(NSString *)key
{
    return objc_getAssociatedObject(self, CFBridgingRetain(key));
}

- (void)hsy_setProperty:(id)property
                 forKey:(nonnull NSString *)key
  objcAssociationPolicy:(kHSYMethodsToolsKitObjcAssociationPolicy)associationPolicy
{
    [self willChangeValueForKey:key];
    objc_AssociationPolicy objcAssociationPolicy = [self.class toObjcAssociationPolicy:associationPolicy];
    objc_setAssociatedObject(self, CFBridgingRetain(key), property, objcAssociationPolicy);
    [self didChangeValueForKey:key];
}

@end
