//
//  NSFileManager+Finder.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSFileManager+Finder.h"
#import "NSBundle+PrivateFileResource.h"
#import "HSYPathMacro.h"

typedef NS_ENUM(NSUInteger, kHSYMethodsToolsFileManagerType) {
    
    kHSYMethodsToolsFileManagerTypeDoucmont,
    kHSYMethodsToolsFileManagerTypeCache,
    kHSYMethodsToolsFileManagerTypeLibrary,
};

@implementation NSFileManager (Finder)

+ (NSString *)hsy_finderFileFromResources:(NSArray<NSDictionary *> *)resources
{
    for (NSDictionary *paramter in resources) {
        NSString *filePath = [self.class hsy_finderFileFromName:paramter.allValues.firstObject
                                                       fileType:paramter.allKeys.firstObject];
        if (filePath.length > 0) {
            return filePath;
        }
    }
    return nil;
}

+ (NSString *)hsy_finderFileFromName:(NSString *)name fileType:(NSString *)type
{
    NSString *resource = [self.class hsy_pathForResource:name fileType:type];
    NSString *doucment = [self.class hsy_pathForDocument:name fileType:type];
    NSString *cache = [self.class hsy_pathForCache:name fileType:type];
    NSString *library = [self.class hsy_pathForLibrary:name fileType:type];
    NSArray *paths = @[
                       resource,
                       doucment,
                       cache,
                       library,
                       ];
    for (NSString *path in paths) {
        if ([self.class hsy_fileExist:path]) {
            return path;
        }
    }
    return @"";
}

+ (BOOL)hsy_fileExist:(NSString *)name fileType:(NSString *)type
{
    NSString *path = [self.class hsy_finderFileFromName:name fileType:type];
    return (path.length > 0);
}

#pragma mark - File Is Downloaded

+ (BOOL)hsy_fileExist:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:filePath];
    return exist;
}

#pragma mark - File Path

+ (NSString *)hsy_pathForDocument:(NSString *)name fileType:(NSString *)type
{
    return [self.class hsy_pathForName:name fileType:type forType:kHSYMethodsToolsFileManagerTypeDoucmont];
}

+ (NSString *)hsy_pathForCache:(NSString *)name fileType:(NSString *)type
{
    return [self.class hsy_pathForName:name fileType:type forType:kHSYMethodsToolsFileManagerTypeCache];
}

+ (NSString *)hsy_pathForLibrary:(NSString *)name fileType:(NSString *)type
{
    return [self.class hsy_pathForName:name fileType:type forType:kHSYMethodsToolsFileManagerTypeLibrary];
}

+ (NSString *)hsy_pathForName:(NSString *)name fileType:(NSString *)fileType forType:(kHSYMethodsToolsFileManagerType)type
{
    NSString *fileName = [NSString stringWithFormat:@"%@.%@", name, fileType];
    NSString *url = @{@(kHSYMethodsToolsFileManagerTypeDoucmont) : HSY_PATH_DOCUMENT,
                      @(kHSYMethodsToolsFileManagerTypeLibrary) : HSY_PATH_LIBRARY,
                      @(kHSYMethodsToolsFileManagerTypeCache) : HSY_PATH_CACHE}[@(type)];
    NSString *path = [NSString stringWithFormat:@"%@/%@", url, fileName];
    if (!path) {
        path = @"";
    }
    return path;
}

+ (NSString *)hsy_pathForResource:(NSString *)name fileType:(NSString *)type
{
    NSString *pathResource = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!pathResource) {
        pathResource = [[NSBundle hsy_resourceBundle] pathForResource:name ofType:type];
        if (!pathResource) {
            pathResource = @"";
        }
    }
    return pathResource;
}

@end
