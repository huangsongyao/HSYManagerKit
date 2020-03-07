//
//  FMResultSet+Querys.h
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/17.
//

#import <fmdb/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@class HSYDatabaseList;
@interface FMResultSet (Querys)

/**
 数据库的“查”操作，快速返回表中的索引内容

 @param list 索引的表
 @return 索引内容
 */
- (NSDictionary *)hsy_dictionaryForDatabaseList:(HSYDatabaseList *)list;

@end

NS_ASSUME_NONNULL_END
