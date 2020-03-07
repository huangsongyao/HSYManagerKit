//
//  HSYDatabaseTools.m
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import "HSYDatabaseTools.h"

static HSYDatabaseTools *datebaseTools = nil;

@implementation HSYDatabaseTools

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        datebaseTools = [[HSYDatabaseTools alloc] init];
    });
    return datebaseTools;
}

- (void)hsy_configDatabase:(NSString *)databaseName listsCreated:(NSArray<HSYDatabaseList *> *)lists
{
    self.database = [[HSYDatabaseData alloc] initWithDBName:databaseName withDatabaseLists:lists.mutableCopy];
    NSMutableArray *listNames = [NSMutableArray arrayWithCapacity:lists.count];
    for (HSYDatabaseList *list in lists) {
        [listNames addObject:list.listName];
    }
}

- (NSString *)hsy_databasePaths
{
    return self.database.databasePathString;
}

@end
