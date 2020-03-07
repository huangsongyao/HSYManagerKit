//
//  FMResultSet+Querys.m
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/17.
//

#import "FMResultSet+Querys.h"
#import "HSYDatabaseList.h"

@implementation FMResultSet (Querys)

- (NSDictionary *)hsy_dictionaryForDatabaseList:(HSYDatabaseList *)list
{
    NSMutableDictionary *queryResult = [[NSMutableDictionary alloc] init];
    for (HSYDatabaseUnity *unity in list.unitys) {
        NSString *value = [self objectForColumn:unity.unityName]; 
        queryResult[unity.unityName] = value;
    }
    return queryResult.mutableCopy;
}

@end
