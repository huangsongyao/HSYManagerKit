//
//  HSYDatabaseUnity.h
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const kHSYDatabaseUnityTypeForText;

@interface HSYDatabaseUnity : JSONModel

//表字段名称
@property (nonatomic, copy) NSString *unityName;
//表字段类型
@property (nonatomic, copy) NSString *unityState;
//表字段的值
@property (nonatomic, copy) NSString *unityValue;

/**
 快速创建，用于[- (instancetype)initWithName:(NSString *)name unityNames:(NSArray *)names queryUnity:(nullable HSYDatabaseUnity *)unity]方法内的数据整理

 @param name column的表字段名
 @return HSYDatabaseUnity
 */
- (instancetype)initWithName:(NSString *)name;

/**
 快速创建，用于创建数据库的数据表的表字段

 @param name column的表字段名
 @param typeString 表字段的类型，如：kHSYDatabaseUnityTypeForText等
 @return HSYDatabaseUnity
 */
- (instancetype)initWithName:(NSString *)name andStateType:(NSString *)typeString;

/**
 快速创建，用于“删”、“改”等数据操作

 @param name column的表字段名
 @param typeString 表字段的类型，如：kHSYDatabaseUnityTypeForText等
 @param value 这个表字段对应的value
 @return HSYDatabaseUnity
 */
- (instancetype)initWithName:(NSString *)name andStateType:(nullable NSString *)typeString unityValue:(nullable NSString *)value;

/**
 用于数据库创建数据表，提供SQL语句的拼接

 @return SQL语句的拼接
 */
- (NSString *)hsy_unityFieldString;

/**
 当数据库的表中进行“增”“删”“改”“查”等操作时，如果column的表字段类型为kHSYDatabaseUnityTypeForText时，需要加上【''】表示

 @return kHSYDatabaseUnityTypeForText类型的真实字段信息
 */
- (NSString *)hsy_unityValueByText;

@end

NS_ASSUME_NONNULL_END
