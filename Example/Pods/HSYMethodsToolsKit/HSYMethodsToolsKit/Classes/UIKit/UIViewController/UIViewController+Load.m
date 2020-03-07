//
//  UIViewController+Load.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "UIViewController+Load.h"
#import "ReactiveObjC.h"
#import "NSObject+Property.h"
#import "NSObject+Runtime.h"
#import "HSYToolsMacro.h"

static NSString *kHSYMethodsToolsRuntimeDelegateForKey      = @"HSYMethodsToolsRuntimeDelegateForKey";

kHSYMethodsToolsKitRuntimeObjectClass const hsyObject       = @"object";
kHSYMethodsToolsKitRuntimeObjectClass const hsyDictionary   = @"dictionary";
kHSYMethodsToolsKitRuntimeObjectClass const hsyArray        = @"array";
kHSYMethodsToolsKitRuntimeObjectClass const hsyNumber       = @"number";
kHSYMethodsToolsKitRuntimeObjectClass const hsyString       = @"string";

@implementation UIViewControllerRuntimeObject

+ (instancetype)initWithDictionary:(NSDictionary<kHSYMethodsToolsKitRuntimeObjectClass, id> *)dictionary
{
    UIViewControllerRuntimeObject *object = [NSObject hsy_objectRuntimeValues:dictionary
                                                                      classes:[UIViewControllerRuntimeObject class]];
    return object;
}

@end

@implementation UIViewController (Load)

- (void)setHsy_runtimeDelegate:(id<UIViewControllerRuntimeDelegate>)hsy_runtimeDelegate
{
    [self hsy_setProperty:hsy_runtimeDelegate
                   forKey:kHSYMethodsToolsRuntimeDelegateForKey
    objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyAssign];
}

- (id<UIViewControllerRuntimeDelegate>)hsy_runtimeDelegate
{
    return [self hsy_getPropertyForKey:kHSYMethodsToolsRuntimeDelegateForKey];
}

+ (void)load
{
    [super load];
    hsy_methodsMonitorInstance(self.class, NSSelectorFromString(@"dealloc"), @selector(hsy_dealloc));
}

- (void)hsy_dealloc
{
    NSLog(@"\n===============%@ dealloc==================", self.class);
    [self hsy_dealloc];
}

@end
