//
//  NSObject+Runtime.h
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)

/**
 NSObject子类中的Model动态转为键值对字典
 
 @return 字典，格式为：key---属性名，value---属性名对应的值
 */
- (NSMutableDictionary *)hsy_toRuntimeMutableDictionary;

/**
 动态实现JSON数据解析成NSObject子类的模型
 
 @param dictionary JSON
 @param classes 要解析成的对象的类名
 @return id
 */
+ (id)hsy_objectRuntimeValues:(NSDictionary <NSString *, id>*)dictionary classes:(Class)classes;

/**
 通过Runtime动态设置对象nil成员
 
 @param object object
 */
+ (void)hsy_setRuntimeValue:(id)object;

/**
 获取对象的类名，返回的是指针runtime类名，例如NSDictionary会返回__NSDictionaryI
 
 @return 例如NSDictionary会返回__NSDictionaryI
 */
- (Class)hsy_objectRuntimeClass;

/**
 获取对象的类名，返回的是指针真实名，例如NSDictionary会返回NSDictionary

 @return 例如NSDictionary会返回NSDictionary
 */
- (NSString *)hsy_objectRuntimeClassName;

/**
 通过Ivar来获取属性成员的类名
 
 @param ivar ivar
 @return 属性成员的类名
 */
+ (NSString *)hsy_objectRuntimeTypeEncoding:(Ivar)ivar;

/**
 通过Ivar获取属性成员的名称
 
 @param ivar ivar
 @return 属性成员的名称
 */
+ (NSString *)hsy_objectRuntimeName:(Ivar)ivar;

/**
 获取对象object的所有属性成员的名称，并返回一个包含所有属性成员名称的数组
 
 @param object object
 @return 包含object所有属性成员名称的数组
 */
+ (NSArray<NSString *> *)hsy_objectRuntimeNames:(id)object;

/**
 获取对象所在类的所有私有+公有的Methods

 @return 所有私有+公有的Methods
 */
- (NSArray<NSString *> *)hsy_runtimeObjectMethods;

/**
 API方法交换，静态方法和实例方法均处理

 @param classes 交换方法的类
 @param originSelector 交换的旧方法，即，class中的API方法
 @param newSelector 交换的新方法，即，即将替代originSelector的方法
 */
void hsy_methodsMonitorInstance(Class classes, SEL originSelector, SEL newSelector);

@end

NS_ASSUME_NONNULL_END
