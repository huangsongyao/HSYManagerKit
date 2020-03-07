//
//  HSYDatabaseTools.h
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import <Foundation/Foundation.h>
#import "HSYDatabaseData.h" 

NS_ASSUME_NONNULL_BEGIN

@interface HSYDatabaseTools : NSObject

//数据库对象
@property (nonatomic, strong) HSYDatabaseData *database;
//表名的集合
@property (nonatomic, copy, readonly) NSArray<NSString *> *listNames;

//单例
+ (instancetype)shareInstance;
//初始化配置数据库
- (void)hsy_configDatabase:(NSString *)databaseName listsCreated:(NSArray<HSYDatabaseList *> *)lists;
//数据库所在的沙盒路径
- (NSString *)hsy_databasePaths;

@end

NS_ASSUME_NONNULL_END
