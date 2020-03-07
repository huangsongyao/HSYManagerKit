//
//  NSObject+Runtime.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSObject+Runtime.h"
#import "HSYToolsMacro.h"
#import "NSString+Replace.h"

@implementation NSObject (Runtime) 

#pragma mark - Model To Dictionary

- (NSMutableDictionary *)hsy_toRuntimeMutableDictionary
{
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSInteger i = 0; i < outCount; i ++) {
        objc_property_t property = propertyList[i];
        NSString *property_attr = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        if (![property_attr hasPrefix:@"T^{"]) {
            const char *propertyName = property_getName(property);
            SEL getter = sel_registerName(propertyName);
            if ([self respondsToSelector:getter]) {
                NSString *propertyString = [[NSString alloc] initWithUTF8String:propertyName];
                id value = [self valueForKey:propertyString];
                if (value) {
                    if ([value isKindOfClass:[self class]]) {
                        value = [value hsy_toRuntimeMutableDictionary];
                    }
                    NSString *key = [NSString stringWithUTF8String:propertyName];
                    [dict setObject:value forKey:key];
                }
            }
        }
    }
    free(propertyList);
    return dict;
}

#pragma mark - JSON/Dictionary To Model

+ (id)hsy_objectRuntimeValues:(NSDictionary <NSString *, id>*)dictionary classes:(Class)classes
{
    id objc = [[classes alloc] init];
    for (NSString *key in dictionary.allKeys) {
        id value = dictionary[key];
        
        objc_property_t property = class_getProperty(classes, key.UTF8String);
        unsigned int outCount = 0;
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount);
        if (!attributeList) {
            continue;
        }
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
        SEL setter = sel_registerName(methodName.UTF8String);
        if ([objc respondsToSelector:setter]) {
            ((void(*)(id,SEL,id)) objc_msgSend)(objc,setter,value);
        }
        free(attributeList);
    }
    [NSObject hsy_setRuntimeValue:objc];
    return objc;
}

#pragma mark - Set Object All Property Content

+ (void)hsy_setRuntimeValue:(id)object
{
    unsigned int count = 0;
    Class classes = [object hsy_objectRuntimeClass];
    Ivar *ivars = class_copyIvarList(classes, &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        id value = object_getIvar(object, ivar);
        if (!value) {
            id setValue = [NSObject hsy_ivarRuntimeValue:[NSObject hsy_objectRuntimeTypeEncoding:ivar]];
            if (!setValue) {
                setValue = [NSNull null];
            }
            object_setIvar(object, ivar, setValue);
        }
    }
    free(ivars);
}

#pragma mark - Get Object Classes

- (Class)hsy_objectRuntimeClass
{
    if (!self) {
        return [NSError class];
    }
    Class classes = object_getClass(self);
    return classes;
}

- (NSString *)hsy_objectRuntimeClassName
{
    NSString *className = [NSStringFromClass(self.hsy_objectRuntimeClass) hsy_stringByReplacingOccurrencesOfSymbol:@"__"];
    return [className substringToIndex:(className.length - 1)];
}

#pragma mark - Get Property Type Name

+ (NSString *)hsy_objectRuntimeTypeEncoding:(Ivar)ivar
{
    if (!ivar) {
        return nil;
    }
    const char *type = ivar_getTypeEncoding(ivar);
    NSString *objectType = [NSString stringWithUTF8String:type];
    return objectType;
}

+ (id)hsy_ivarRuntimeValue:(NSString *)typeName
{
    if ([typeName isEqualToString:@"@\"NSString\""]) {
        return @"";
    } else if ([typeName isEqualToString:@"@\"NSNumber\""]) {
        return @(0);
    } else if ([typeName isEqualToString:@"@\"NSArray\""]) {
        return @[];
    } else if ([typeName isEqualToString:@"@\"NSDictionary\""]) {
        return @{};
    } else if ([typeName isEqualToString:@"@\"NSMutableArray\""]) {
        return [@[] mutableCopy];
    } else if ([typeName isEqualToString:@"@\"NSMutableDictionary\""]) {
        return [@{} mutableCopy];
    } else if ([typeName isEqualToString:@"@\"NSDate\""]) {
        return [NSDate date];
    } else if ([typeName isEqualToString:@"@\"NSData\""]) {
        return [NSData data];
    }
    return nil;
}

#pragma mark - Get Property Name

+ (NSString *)hsy_objectRuntimeName:(Ivar)ivar
{
    if (!ivar) {
        return nil;
    }
    const char *name = ivar_getName(ivar);
    NSString *objectName = [NSString stringWithUTF8String:name];
    objectName = [objectName substringWithRange:NSMakeRange(1, (objectName.length - 1))];
    return objectName;
}

#pragma mark - Get All Property Names

+ (NSArray<NSString *> *)hsy_objectRuntimeNames:(id)object
{
    unsigned int propertys = 0;
    Class classes = [object hsy_objectRuntimeClass];
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:propertys];
    objc_property_t *propertyLists = class_copyPropertyList(classes, &propertys);
    for (NSInteger i = 0; i < propertys; i ++) {
        const char *propertyName = property_getName(propertyLists[i]);
        NSString *forKey = [NSString stringWithUTF8String:propertyName];
        [results addObject:forKey];
    }
    free(propertyLists);
    return results;
}

#pragma mark - Get Class Methods APIs

- (NSArray<NSString *> *)hsy_runtimeObjectMethods
{
    unsigned int count;
    NSMutableArray *propertys = [[NSMutableArray alloc] init];
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        [propertys addObject:name];
    }
    free(methods);
    NSLog(@"\n %@ all private API list", propertys);
    return propertys.mutableCopy;
}

void hsy_methodsMonitorInstance(Class classes, SEL originSelector, SEL newSelector)
{
    //class_getInstanceMethod     得到类的实例方法
    //class_getClassMethod        得到类的类方法
    Method originMethod = class_getInstanceMethod(classes, originSelector);
    Method newMethod = class_getInstanceMethod(classes, newSelector);
    if(class_addMethod(classes, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(classes, newSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, newMethod);//交换方法
    }
}

@end
