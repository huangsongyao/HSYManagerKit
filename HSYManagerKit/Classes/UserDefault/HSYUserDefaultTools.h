//
//  HSYUserDefaultTools.h
//  HSYManagerKit
//
//  Created by anmin on 2019/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class JSONModel;
@interface HSYUserDefaultTools : NSObject

+ (instancetype)shareInstance;

#pragma mark - NSUserDefaults

/**
 NSUserDefaults获取缓存内容
 
 @param key key
 @return id
 */
+ (id)hsy_objectForKey:(NSString *)key;

/**
 NSUserDefaults设置缓存内容
 
 @param object 缓存对象
 @param key key
 */
+ (void)hsy_setObject:(id)object forKey:(NSString *)key;

/**
 NSUserDefaults删除缓存内容
 
 @param key key
 */
+ (void)hsy_removeObjectForKey:(NSString *)key;

/**
 NSUserDefaults获取JSONModel对象
 
 @param key key
 @param classes JSONModel子类的类型
 @return JSONModel
 */
+ (JSONModel *)hsy_JSONModelForKey:(NSString *)key class:(Class)classes;

/**
 NSUserDefaults缓存SONModel对象
 
 @param model model
 @param key key
 */
+ (void)hsy_setJSNModel:(JSONModel *)model forKey:(NSString *)key;

/**
 NSUserDefaults获取字典
 
 @param key key
 @return NSDictionary
 */
+ (NSDictionary *)hsy_dictionaryForKey:(NSString *)key;

/**
 NSUserDefaults缓存字典
 
 @param dic 字典
 @param key key
 */
+ (void)hsy_setDictionary:(NSDictionary *)dic forKey:(NSString *)key;

/**
 NSUserDefaults获取数组
 
 @param key key
 @return NSArray
 */
+ (NSArray *)hsy_arrayForKey:(NSString *)key;

/**
 NSUserDefaults缓存数组
 
 @param array 数组
 @param key key
 */
+ (void)hsy_setArray:(NSArray *)array forKey:(NSString *)key;

/**
 NSUserDefaults获取字符串
 
 @param key key
 @return NSString
 */
+ (NSString *)hsy_stringForKey:(NSString *)key;

/**
 NSUserDefaults缓存字符串
 
 @param string 字符串
 @param key key
 */
+ (void)hsy_setString:(NSString *)string forKey:(NSString *)key;

#pragma mark - Image Cache

/**
 获取当前app中SDWebImage的图片缓存大小，单位为M
 
 @return 获取当前app中SDWebImage的图片缓存大小
 */
- (NSString *)hsy_currentAppImageCacheDiskSizes;

/**
 清除当前app中SDWebImage的图片缓存内容
 */
- (void)hsy_clearImageCache;

/**
 清除当前app中SDWebImage的图片缓存内容
 
 @param completed 操作执行完毕后的回调
 */
+ (void)hsy_clearImageCache:(void(^)(BOOL finished))completed;

#pragma mark - Resources File

/**
 将工程中的plist文件转为NSDictionary的对象
 
 @param name plsit文件名称
 @return NSDictionary
 */
+ (NSDictionary *)hsy_dictionaryWithPlist:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
