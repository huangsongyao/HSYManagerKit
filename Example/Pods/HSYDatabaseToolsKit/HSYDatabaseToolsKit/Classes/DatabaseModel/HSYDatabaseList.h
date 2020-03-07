//
//  HSYDatabaseList.h
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import <JSONModel/JSONModel.h>
#import "HSYDatabaseUnity.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSYDatabaseList : JSONModel

//数据库表名
@property (nonatomic, copy) NSString *listName;
//用于--->创建数据库表的数据库表字段
@property (nonatomic, strong, readonly) NSMutableArray<HSYDatabaseUnity *> *unitys;
//用于--->需要执行“增”“删”“查”等SQL操作的数据，如果是插入，则可能有多个数据，如果是修改和删除则只有单个数据
@property (nonatomic, strong, readonly) NSMutableArray<HSYDatabaseUnity *> *updateUnitys;
//用于--->需要执行“改”的SQL操作的数据，格式为：@[@{HSYDatabaseUnity *old, HSYDatabaseUnity *new}, ...]
@property (nonatomic, strong, readonly) NSArray<NSDictionary<HSYDatabaseUnity *, HSYDatabaseUnity *> *> *modifyUnitys;

/**
 快速创建，可用于“查询整张表的数据”的操作

 @param name 表名
 @param names 表字段column名的集合，即，name表中所有的字段
 @return HSYDatabaseList
 */
- (instancetype)initWithName:(NSString *)name unityNames:(NSArray *)names;

/**
 快速创建，可用于“查”的数据操作

 @param name 表名
 @param names 表字段column名的集合，即，name表中所有的字段
 @param unity 查询的依据
 @return HSYDatabaseList
 */
- (instancetype)initWithName:(NSString *)name unityNames:(NSArray *)names queryUnity:(nullable HSYDatabaseUnity *)unity;

/**
 快速创建，可用于“创建数据库数据表”的操作

 @param name 表名
 @param unitys 表的字段名称，格式为: @[HSYDatabaseUnity *字段1, HSYDatabaseUnity *字段2, HSYDatabaseUnity *字段3, ... ]，有效字段为: self.unitys
 @return HSYDatabaseList
 */
- (instancetype)initWithName:(NSString *)name databaseUnitys:(NSArray<HSYDatabaseUnity *> *)unitys;

/**
 快速创建，可用于“增”“删”等SQL的数据操作
 
 @param name 表名
 @param unitys 将要更新的数据，有效字段为: self.updateUnitys，其中：对于“增”操作 --> unitys参数中的HSYDatabaseUnity需要包含name表中所有的column字段名称，这样才能依次插入数据到整行中；对于“删”操作，unitys参数中的HSYDatabaseUnity只需要含有需要删除的某一项column的字段名称；
 @return HSYDatabaseList
 */
- (instancetype)initWithName:(NSString *)name updateUnitys:(NSArray<HSYDatabaseUnity *> *)unitys;

/**
 快速创建，可用于“改”的SQL的数据操作

 @param name 表名
 @param unitys 需要执行“改”操作的数据，格式为: @[@{HSYDatabaseUnity *old, HSYDatabaseUnity *new}, ...]，其中，old表示需要更新的column的表字段所对应的表字段的name和当前数据库表中的对应的value，new表示需要更新的column的表字段所对应的表字段的name和当前要更新到表中的对应的value
 @return HSYDatabaseList
 */
- (instancetype)initWithName:(NSString *)name modifyUnitys:(NSArray<NSDictionary<HSYDatabaseUnity *, HSYDatabaseUnity *> *> *)unitys;

#pragma mark - SQL Code

/**
 返回一个SQL的创建表语句

 @return 创建表语句
 */
- (NSString *)hsy_listCreatedSQLString;

/**
 返回一个SQL的插入语句

 @return 插入语句
 */
- (NSString *)hsy_insertDatasSQLString;

/**
 返回一个SQL的删除语句

 @return 删除语句
 */
- (NSString *)hsy_deleteDatasSQLString;

/**
 返回一个SQL的修改语句

 @return 修改语句
 */
- (NSString *)hsy_modifyDatasSQLString;

/**
 返回一个SQL的查询语句，查询对象为self.updateUnitys中满足条件的rows

 @return 查询语句
 */
- (NSString *)hsy_queryDatasSQLString;

/**
 返回一个SQL的查询语句，查询对象为整张表中所有的数据
 
 @return 查询语句
 */
- (NSString *)hsy_queryAllListDatasSQLString;

/**
 返回一个SQL的清除表数据的语句，清除表中所有的数据

 @return 清除表数据的语句
 */
- (NSString *)hsy_listCleanDatasSQLString;

@end

NS_ASSUME_NONNULL_END
