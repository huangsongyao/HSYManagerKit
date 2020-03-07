//
//  HSYDatabaseData.m
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import "HSYDatabaseData.h"
#import <fmdb/FMDB.h>
#import <HSYMacroKit/HSYPathMacro.h>
#import <HSYMacroKit/HSYToolsMacro.h>
#import <HSYMethodsToolsKit/RACSignal+Combined.h>
#import "FMResultSet+Querys.h"

typedef RACSignal<RACTuple *> *(^HSYDatabaseDataOperationBlock)(RACTuple *tuple);

typedef NS_ENUM(NSUInteger, kHSYDatabaseDataOperateState) {
    
    kHSYDatabaseDataOperateStateInsert      = 1991,
    kHSYDatabaseDataOperateStateDelete,
    kHSYDatabaseDataOperateStateModify,
    kHSYDatabaseDataOperateStateQuery,
    
};

@interface HSYDatabaseData ()

@property (nonatomic, copy) NSString *databasePaths;
@property (nonatomic, strong) FMDatabase *databases;
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end

@implementation HSYDatabaseData

- (instancetype)initWithDBName:(NSString *)datebaseName withDatabaseLists:(nonnull NSMutableArray<HSYDatabaseList *> *)lists
{
    if (self = [super init]) {
        _databaseName = datebaseName;
        _lists = lists.mutableCopy;
        self.databases.logsErrors = YES;
    }
    return self;
}

#pragma mark - Lazy

- (NSString *)databasePaths
{
    if (!_databasePaths) {
        _databasePaths = [NSString stringWithFormat:@"%@/%@", self.class.documentDirectory, self.databaseName];
        NSLog(@"\n Database doucment path is :%@\n", _databasePaths);
    }
    return _databasePaths;
}

- (FMDatabase *)databases
{
    if (!_databases) {
        _databases = [[FMDatabase alloc] initWithPath:self.databasePaths];
        _databases.traceExecution = YES;
        if ([_databases open]) {
            for (HSYDatabaseList *list in self.lists) {
                BOOL exist = [_databases tableExists:list.listName];
                if (!exist) {
                    BOOL listCreated = [_databases executeUpdateWithFormat:list.hsy_listCreatedSQLString, nil];
                    NSLog(@"create db list: [%@], create result: [%@]", list.listName, (listCreated ? @"success" : @"failure"));
                }
            }
            [_databases close];
        }
    }
    return _databases;
} 

- (FMDatabaseQueue *)databaseQueue
{
    if (!_databaseQueue) {
        _databaseQueue = [[FMDatabaseQueue alloc] initWithPath:self.databases.databasePath];
    }
    return _databaseQueue;
}

#pragma mark - Database Operation

- (void)hsy_inDatabase:(HSYDatabaseDataOperationBlock)operationBlock
{
    @weakify(self);
    [[RACScheduler scheduler] schedule:^{
        @strongify(self);
        [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            RACSignal<RACTuple *> *signal = operationBlock(RACTuplePack(db));
            [[signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple * _Nullable x) {
                if ([x.first boolValue]) {
                    [(FMDatabase *)x.second close];
                }
            }];
        }];
    }];
}

- (RACSignal<NSNumber *> *)hsy_updateDatabaseDatas:(NSArray<HSYDatabaseList *> *)lists operateState:(kHSYDatabaseDataOperateState)state
{
    @weakify(self);
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber1) {
        @strongify(self);
        [self hsy_inDatabase:^RACSignal<RACTuple *> *(RACTuple *tuple) {
            return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber2) {
                FMDatabase *database = (FMDatabase *)tuple.first;
                BOOL transactionResult = YES;
                if ([database open]) {
                    [database beginTransaction];
                    NSString *operateString = @{@(kHSYDatabaseDataOperateStateInsert) : @"insert",
                                                @(kHSYDatabaseDataOperateStateDelete) : @"delete",
                                                @(kHSYDatabaseDataOperateStateModify) : @"modify"}[@(state)];
                    for (HSYDatabaseList *list in lists) {
                        if (list.updateUnitys.count) {
                            NSString *sqlString = nil;
                            switch (state) {
                                case kHSYDatabaseDataOperateStateInsert:
                                    sqlString = list.hsy_insertDatasSQLString;
                                    break;
                                case kHSYDatabaseDataOperateStateDelete:
                                    sqlString = list.hsy_deleteDatasSQLString;
                                    break;
                                case kHSYDatabaseDataOperateStateModify:
                                    sqlString = list.hsy_modifyDatasSQLString;
                                    break;
                                default:
                                    break;
                            }
                            BOOL operateResult = [database executeUpdateWithFormat:sqlString, nil];
                            if (!operateResult) {
                                NSLog(@"%@ data failure! -> list: [%@]", operateString, list);
                                [database rollback];
                                transactionResult = !transactionResult;
                            }
                        }
                    }
                    if (transactionResult) {
                        NSLog(@"%@ data success! -> lists: [%@]", operateString, lists);
                        [database commit];
                    }
                }
                [RACSignal hsy_performSendSignal:subscriber2 forObject:RACTuplePack(@(YES), database)];
                [RACSignal hsy_performSendSignal:subscriber1 forObject:@(transactionResult)];
            }];
        }];
    }];
}

#pragma mark - Insert

- (RACSignal<NSNumber *> *)hsy_insertDatas:(NSArray<HSYDatabaseList *> *)lists
{
    return [self hsy_updateDatabaseDatas:lists operateState:kHSYDatabaseDataOperateStateInsert];
}

- (RACSignal<NSNumber *> *)hsy_insertData:(HSYDatabaseList *)list
{
    return [self hsy_insertDatas:@[list]];
}

#pragma mark - Delete

- (RACSignal<NSNumber *> *)hsy_deleteDatas:(NSArray<HSYDatabaseList *> *)lists
{
    return [self hsy_updateDatabaseDatas:lists operateState:kHSYDatabaseDataOperateStateDelete];
}

- (RACSignal<NSNumber *> *)hsy_deleteData:(HSYDatabaseList *)list
{
    return [self hsy_deleteDatas:@[list]];
}

#pragma mark - Modify

- (RACSignal<NSNumber *> *)hsy_modifyDatas:(NSArray<HSYDatabaseList *> *)lists
{
    return [self hsy_updateDatabaseDatas:lists operateState:kHSYDatabaseDataOperateStateModify];
}

- (RACSignal<NSNumber *> *)hsy_modifyData:(HSYDatabaseList *)list
{
    return [self hsy_modifyDatas:@[list]];
}

#pragma mark - Query

- (RACSignal<NSMutableArray<NSDictionary *> *> *)hsy_queryDatas:(HSYDatabaseList *)list isQueryAllDatas:(BOOL)queryAllDatas
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber1) {
        [self hsy_inDatabase:^RACSignal<RACTuple *> *(RACTuple *tuple) {
            return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber2) {
                FMDatabase *database = (FMDatabase *)tuple.first;
                NSString *sqlString = (queryAllDatas ? list.hsy_queryAllListDatasSQLString : list.hsy_queryDatasSQLString);
                FMResultSet *resultSet = [database executeQueryWithFormat:sqlString, nil];
                NSMutableArray<NSDictionary *> *results = [[NSMutableArray alloc] init];
                while ([resultSet next]) {
                    NSDictionary *result = [resultSet hsy_dictionaryForDatabaseList:list];
                    [results addObject:result];
                }
                [resultSet close];
                [RACSignal hsy_performSendSignal:subscriber2 forObject:RACTuplePack(@(YES), database)];
                [RACSignal hsy_performSendSignal:subscriber1 forObject:results];
            }];
        }];
    }];
}

- (RACSignal<NSMutableArray<NSDictionary *> *> *)hsy_queryDatas:(HSYDatabaseList *)list
{
    return [self hsy_queryDatas:list isQueryAllDatas:NO];
}

- (RACSignal<NSMutableArray<NSDictionary *> *> *)hsy_queryAllDatas:(HSYDatabaseList *)list
{
    return [self hsy_queryDatas:list isQueryAllDatas:YES];
}

#pragma mark - Clean

- (RACSignal<NSArray<RACTuple *> *> *)hsy_databaseClean
{
    @weakify(self);
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSMutableArray<RACSignal<NSNumber *> *> *zipSignals = [NSMutableArray arrayWithCapacity:self.lists.count];
        for (HSYDatabaseList *thisList in self.lists) {
            [zipSignals addObject:[self hsy_listClean:thisList.listName]];
        }
        [[[RACSignal hsy_zipSignals:zipSignals] deliverOn:[RACScheduler scheduler]] subscribeNext:^(NSArray<RACTuple *> * _Nullable x) {
            NSLog(@"zip signals -> result = %@", x);
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
    }];
}

- (RACSignal<NSNumber *> *)hsy_listClean:(NSString *)listName
{
    @weakify(self);
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber1) {
        @strongify(self);
        [self hsy_inDatabase:^RACSignal<RACTuple *> *(RACTuple *tuple) {
            return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber2) {
                @strongify(self);
                HSYDatabaseList *list = nil;
                for (HSYDatabaseList *thisList in self.lists) {
                    if ([thisList.listName isEqualToString:listName]) {
                        list = thisList;
                        break;
                    }
                }
                FMDatabase *database = (FMDatabase *)tuple.first;
                if (!list) {
                    [RACSignal hsy_performSendSignal:subscriber2 forObject:RACTuplePack(@(YES), database)];
                    NSLog(@"clean failure! -> 数据库未找到listName = %@ 的表数据，请检查!", listName);
                    return;
                }
                BOOL clean = [database executeUpdateWithFormat:list.hsy_listCleanDatasSQLString, nil];
                [RACSignal hsy_performSendSignal:subscriber2 forObject:RACTuplePack(@(YES), database)];
                [RACSignal hsy_performSendSignal:subscriber1 forObject:@(clean)];
            }];
        }];
    }];
}

#pragma mark - Database Path

+ (NSString *)documentDirectory
{
    return HSY_PATH_DOCUMENT;
}

- (NSString *)databasePathString
{
    return self.databasePaths.copy;
}

@end
