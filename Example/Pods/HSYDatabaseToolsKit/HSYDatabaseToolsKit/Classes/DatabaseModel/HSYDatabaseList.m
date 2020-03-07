//
//  HSYDatabaseList.m
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import "HSYDatabaseList.h"
#import <HSYMethodsToolsKit/NSObject+JSONModel.h>
#import <HSYMacroKit/HSYToolsMacro.h>

@implementation HSYDatabaseList

- (instancetype)initWithName:(NSString *)name unityNames:(NSArray *)names
{
    return [self initWithName:name unityNames:names queryUnity:nil];
}

- (instancetype)initWithName:(NSString *)name unityNames:(NSArray *)names queryUnity:(nullable HSYDatabaseUnity *)unity
{
    if (self = [super init]) {
        _listName = name;
        _unitys = [NSMutableArray arrayWithCapacity:names.count];
        for (NSString *name in names) {
            HSYDatabaseUnity *unity = [[HSYDatabaseUnity alloc] initWithName:name];
            [self.unitys addObject:unity];
        }
        if (unity) {
            _updateUnitys = [@[unity, ] mutableCopy];
        }
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name databaseUnitys:(NSArray<HSYDatabaseUnity *> *)unitys
{
    if (self = [super init]) {
        _listName = name;
        _unitys = unitys.mutableCopy;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name updateUnitys:(NSArray<HSYDatabaseUnity *> *)unitys
{
    if (self = [super init]) {
        _listName = name;
        _updateUnitys = unitys.mutableCopy;
        _unitys = [NSMutableArray arrayWithCapacity:self.updateUnitys.count];
        for (HSYDatabaseUnity *updateUnity in self.updateUnitys) {
            HSYDatabaseUnity *unity = [HSYDatabaseUnity hsy_toJSONModel:updateUnity.toDictionary forModelClasses:[HSYDatabaseUnity class]];
            unity.unityValue = @"";
            [self.unitys addObject:unity];
        }
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name modifyUnitys:(NSArray<NSDictionary<HSYDatabaseUnity *,HSYDatabaseUnity *> *> *)unitys
{
    if (self = [super init]) {
        _listName = name;
        _modifyUnitys = unitys.mutableCopy;
    }
    return self;
}

#pragma mark - Update Datas

- (NSString *)toDatabaseListUnityString
{
    if (!self.unitys.count) {
        return nil;
    }
    HSYDatabaseUnity *firstUnity = self.unitys.firstObject;
    NSString *listUnityString = firstUnity.hsy_unityFieldString;
    for (HSYDatabaseUnity *unity in self.unitys) {
        if (![unity isEqual:firstUnity]) {
            listUnityString = [NSString stringWithFormat:@"%@,%@", listUnityString, unity.hsy_unityFieldString];
        }
    }
    return listUnityString;
}

- (NSDictionary *)toDatabaseListUnityDictionary
{
    if (!self.updateUnitys.count) {
        return nil;
    }
    NSString *unityNames = self.updateUnitys.firstObject.unityName;
    NSString *unityValues = self.updateUnitys.firstObject.hsy_unityValueByText;
    for (HSYDatabaseUnity *unity in self.updateUnitys) {
        if (![unity.unityName isEqualToString:unityNames]) {
            unityNames = [NSString stringWithFormat:@"%@,%@", unityNames, unity.unityName];
            unityValues = [NSString stringWithFormat:@"%@,%@", unityValues, unity.hsy_unityValueByText];
        }
    }
    return @{unityNames : unityValues};
}

#pragma mark - SQL

- (NSString *)hsy_listCreatedSQLString
{
    NSString *listCreatedSQLString = [NSString stringWithFormat:@"CREATE TABLE %@ (%@)", self.listName, self.toDatabaseListUnityString];
    NSLog(@"database operation --> create list SQL code: %@", listCreatedSQLString);
    return listCreatedSQLString;
}

- (NSString *)hsy_insertDatasSQLString
{
    NSDictionary *insertDictionary = self.toDatabaseListUnityDictionary;
    NSString *insertDatasSQLString = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)", self.listName, insertDictionary.allKeys.firstObject, insertDictionary.allValues.firstObject];
    NSLog(@"database operation --> insert data SQL code: %@", insertDatasSQLString);
    return insertDatasSQLString;
}

- (NSString *)hsy_deleteDatasSQLString
{
    HSYDatabaseUnity *firstUnity = self.updateUnitys.firstObject;
    NSString *deleteDatasSQLString = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %@", self.listName, firstUnity.unityName, firstUnity.hsy_unityValueByText];
    NSLog(@"database operation --> delete data SQL code: %@", deleteDatasSQLString);
    return deleteDatasSQLString;
}

- (NSString *)hsy_modifyDatasSQLString
{
    HSYDatabaseUnity *whereUnity = [self.modifyUnitys.firstObject allKeys].firstObject;
    HSYDatabaseUnity *updateUnity = [self.modifyUnitys.firstObject allValues].firstObject;
    NSString *modifyDatasSQLString = [NSString stringWithFormat:@"UPDATE %@ SET %@ = %@ WHERE %@ = %@", self.listName, updateUnity.unityName, updateUnity.hsy_unityValueByText, whereUnity.unityName, whereUnity.hsy_unityValueByText];
    NSLog(@"database operation --> modify data SQL code: %@", modifyDatasSQLString);
    return modifyDatasSQLString;
}

- (NSString *)hsy_queryDatasSQLString
{
    HSYDatabaseUnity *firstUnity = self.updateUnitys.firstObject;
    NSString *queryDatasSQLString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = %@", self.listName, firstUnity.unityName, firstUnity.hsy_unityValueByText];
    NSLog(@"database operation --> query some datas SQL code: %@", queryDatasSQLString);
    return queryDatasSQLString;
}

- (NSString *)hsy_queryAllListDatasSQLString
{
    NSString *queryAllListDatasSQLString = [NSString stringWithFormat:@"SELECT * FROM %@", self.listName];
    NSLog(@"database operation --> query all datas SQL code: %@", queryAllListDatasSQLString);
    return queryAllListDatasSQLString;
}

- (NSString *)hsy_listCleanDatasSQLString
{
    NSString *listCleanDatasSQLString = [NSString stringWithFormat:@"DELETE FROM %@", self.listName];
    NSLog(@"database operation --> clean list datas SQL code: %@", listCleanDatasSQLString);
    return listCleanDatasSQLString;
} 

@end
