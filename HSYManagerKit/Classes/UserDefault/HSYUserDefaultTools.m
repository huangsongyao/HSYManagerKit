//
//  HSYUserDefaultTools.m
//  HSYManagerKit
//
//  Created by anmin on 2019/10/18.
//

#import "HSYUserDefaultTools.h"
#import <JSONModel/JSONModel.h>
#import <HSYMethodsToolsKit/NSObject+JSONModel.h>
#import <HSYMethodsToolsKit/NSFileManager+Finder.h>
#import <SDWebImage/SDImageCache.h>

static HSYUserDefaultTools *userDefaultTools = nil;

@implementation HSYUserDefaultTools

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDefaultTools = [[HSYUserDefaultTools alloc] init];
    });
    return userDefaultTools;
}

#pragma mark - UserDefaults

+ (id)hsy_objectForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id object = [userDefaults objectForKey:key];
    return object;
}

+ (void)hsy_setObject:(id)object forKey:(NSString *)key
{
    [self.class hsy_removeObjectForKey:key];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
}

+ (void)hsy_removeObjectForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
}

+ (JSONModel *)hsy_JSONModelForKey:(NSString *)key class:(Class)classes
{
    id object = [self.class hsy_objectForKey:key];
    JSONModel *model = [NSObject hsy_toJSONModel:object forModelClasses:classes];
    return model;
}

+ (void)hsy_setJSNModel:(JSONModel *)model forKey:(NSString *)key
{
    NSDictionary *json = model.toDictionary;
    [self.class hsy_setObject:json forKey:key];
}

+ (NSDictionary *)hsy_dictionaryForKey:(NSString *)key
{
    id object = [self.class hsy_objectForKey:key];
    NSDictionary *dic = (NSDictionary *)object;
    return dic;
}

+ (void)hsy_setDictionary:(NSDictionary *)dic forKey:(NSString *)key
{
    [self.class hsy_setObject:dic forKey:key];
}

+ (NSArray *)hsy_arrayForKey:(NSString *)key
{
    id object = [self.class hsy_objectForKey:key];
    NSArray *array = (NSArray *)object;
    return array;
}

+ (void)hsy_setArray:(NSArray *)array forKey:(NSString *)key
{
    [self.class hsy_setObject:array forKey:key];
}

+ (NSString *)hsy_stringForKey:(NSString *)key
{
    id object = [self.class hsy_objectForKey:key];
    NSString *string = (NSString *)object;
    return string;
} 

+ (void)hsy_setString:(NSString *)string forKey:(NSString *)key
{
    [self.class hsy_setObject:string forKey:key];
}

#pragma mark - Clear Image Cache

- (NSString *)hsy_currentAppImageCacheDiskSizes
{
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
    CGFloat cache = bytesCache/1000/1000;
    NSString *cacheString = [NSString stringWithFormat:@"%.2fM", cache];
    
    return cacheString;
}

- (void)hsy_clearImageCache
{
    [self.class hsy_clearImageCache:^(BOOL finished) {}];
}

+ (void)hsy_clearImageCache:(void(^)(BOOL finished))completed
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        if (completed) {
            completed(YES);
        }
    }];
}

#pragma mark - File

+ (NSDictionary *)hsy_dictionaryWithPlist:(NSString *)name
{
    NSString *filePath = [NSFileManager hsy_finderFileFromName:name fileType:@"plist"];
    if (!filePath.length) { 
        NSLog(@"%@ file not finder path！", name);
        return nil;
    }
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dictionary;
}

@end
