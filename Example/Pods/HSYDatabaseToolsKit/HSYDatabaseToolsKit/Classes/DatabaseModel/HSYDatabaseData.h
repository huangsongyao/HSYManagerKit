//
//  HSYDatabaseData.h
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import <JSONModel/JSONModel.h> 
#import <HSYMethodsToolsKit/RACSignal+Convenients.h>
#import "HSYDatabaseList.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSYDatabaseData : JSONModel

//数据库的库名
@property (nonatomic, copy, readonly) NSString *databaseName;
//数据库对应的多张表
@property (nonatomic, strong, readonly) NSMutableArray<HSYDatabaseList *> *lists;

/**
 数据库对象初始化

 @param datebaseName 数据库的库名
 @param lists 数据库对应的多张表，已创建的不会修改，新增的则创建
 @return HSYDatabaseData
 */
- (instancetype)initWithDBName:(NSString *)datebaseName withDatabaseLists:(NSMutableArray<HSYDatabaseList *> *)lists;

/**
 数据库所在的本地沙盒地址

 @return 数据库地址
 */
- (NSString *)databasePathString;

#pragma mark - Insert

/**
 插入操作，支持事务及多线程

 @param lists 插入的数据
 @return 返回插入数据的结果，如果是多项插入，其中一项插入失败，则执行回滚
 */
- (RACSignal<NSNumber *> *)hsy_insertDatas:(NSArray<HSYDatabaseList *> *)lists;
- (RACSignal *)hsy_insertData:(HSYDatabaseList *)list;

#pragma mark - Delete

/**
 删除操作，支持事务及多线程

 @param lists 删除的数据
 @return 返回删除数据的结果，如果是多项删除，其中一项删除失败，则执行回滚
 */
- (RACSignal<NSNumber *> *)hsy_deleteDatas:(NSArray<HSYDatabaseList *> *)lists;
- (RACSignal<NSNumber *> *)hsy_deleteData:(HSYDatabaseList *)list;

#pragma mark - Modify

/**
 修改操作，支持事务及多线程

 @param lists 修改的数据
 @return 返回修改数据的结果，如果是多项修改，其中一项修改失败，则执行回滚
 */
- (RACSignal<NSNumber *> *)hsy_modifyDatas:(NSArray<HSYDatabaseList *> *)lists;
- (RACSignal<NSNumber *> *)hsy_modifyData:(HSYDatabaseList *)list;

#pragma mark - Query

/**
 搜索操作，只搜索对应表内满足条件的内容

 @param list 搜索条件
 @return 满足条件的内容，返回的数据格式为key-value，其中，key为对应的表中的字段名称
 */
- (RACSignal<NSMutableArray<NSDictionary *> *> *)hsy_queryDatas:(HSYDatabaseList *)list;

/**
 搜索操作，返回表中所有的数据

 @param list 搜索条件
 @return 满足条件的内容，返回的数据格式为key-value，其中，key为对应的表中的字段名称
 */
- (RACSignal<NSMutableArray<NSDictionary *> *> *)hsy_queryAllDatas:(HSYDatabaseList *)list;

#pragma mark - Clean

/**
 清空整个数据库中所有的数据

 @return RACSignal<RACTuple *> *
 */
- (RACSignal<NSArray<RACTuple *> *> *)hsy_databaseClean;

/**
 清空listName表中的所有数据

 @param listName 表名
 @return RACSignal<NSNumber *> *
 */
- (RACSignal<NSNumber *> *)hsy_listClean:(NSString *)listName;

@end

NS_ASSUME_NONNULL_END
