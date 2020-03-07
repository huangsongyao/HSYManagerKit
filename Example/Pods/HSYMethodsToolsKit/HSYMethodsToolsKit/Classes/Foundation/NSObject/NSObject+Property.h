//
//  NSObject+Property.h
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, kHSYMethodsToolsKitObjcAssociationPolicy) {
    
    kHSYMethodsToolsKitObjcAssociationPolicyAssign              = 2018, //weak+assign类型
    kHSYMethodsToolsKitObjcAssociationPolicyNonatomicStrong,            //非原子性的strong+retain
    kHSYMethodsToolsKitObjcAssociationPolicyNonatomicCopy,              //非原子性的copy
    kHSYMethodsToolsKitObjcAssociationPolicyAtomicStrong,               //原子性的strong+retain
    kHSYMethodsToolsKitObjcAssociationPolicyAtomicCopy,                 //原子性的copy
    
};

@interface NSObject (Property)

/**
 runtime动态添加属性成员
 
 @param key key
 @return id
 */
- (id)hsy_getPropertyForKey:(NSString *)key;

/**
 runtime动态添加属性成员
 
 @param property id
 @param key key
 @param associationPolicy kHSYMethodsToolsKitObjcAssociationPolicy枚举
 */
- (void)hsy_setProperty:(id)property
                 forKey:(NSString *)key
  objcAssociationPolicy:(kHSYMethodsToolsKitObjcAssociationPolicy)associationPolicy;


@end

NS_ASSUME_NONNULL_END
