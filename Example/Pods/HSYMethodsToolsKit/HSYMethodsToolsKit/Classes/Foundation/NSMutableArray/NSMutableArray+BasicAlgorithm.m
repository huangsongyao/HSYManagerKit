//
//  NSMutableArray+BasicAlgorithm.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/26.
//

#import "NSMutableArray+BasicAlgorithm.h"

@implementation NSMutableArray (BasicAlgorithm)

#pragma mark - NSSortDescriptor

- (NSArray *)hsy_sortDescriptor:(BOOL)isAscending forKeys:(NSArray *)keys
{
    NSMutableArray *descriptors = [NSMutableArray arrayWithCapacity:keys.count];
    for (id key in keys) {
        id realKey = key;
        if (![realKey isKindOfClass:[NSString class]]) {
            realKey = @"integerValue";
        }
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:realKey ascending:isAscending];
        [descriptors addObject:descriptor];
    }
    NSArray *sortResults = [self sortedArrayUsingDescriptors:[descriptors mutableCopy]];
    return sortResults;
}

- (void)hsy_sortUsingDescriptor:(BOOL)isAscending forKeys:(NSArray *)keys
{
    NSArray *sortResults = [self hsy_sortDescriptor:isAscending forKeys:keys];
    for (id object in sortResults) {
        [self replaceObjectAtIndex:[sortResults indexOfObject:object] withObject:object];
    }
}

#pragma mark - NSSortDescriptor Number Up

- (NSArray *)hsy_ascendingOrderSort
{
    NSArray *sortArray = [self hsy_sortDescriptor:YES forKeys:@[[NSNull null]]];
    return sortArray;
}

- (void)hsy_bubbleAscendingOrderSort
{
    NSArray *ascendings = self.hsy_ascendingOrderSort;
    for (id object in ascendings) {
        [self replaceObjectAtIndex:[ascendings indexOfObject:object] withObject:object];
    }
}

#pragma mark - NSSortDescriptor Number Down

- (NSArray *)hsy_descendingOrderSort
{
    NSArray *sortArray = [self hsy_sortDescriptor:NO forKeys:@[[NSNull null]]];
    return sortArray;
}

- (void)hsy_bubbleDescendingOrderSort
{
    NSArray *ascendings = self.hsy_descendingOrderSort;
    for (id object in ascendings) {
        [self replaceObjectAtIndex:[ascendings indexOfObject:object] withObject:object];
    }
}

#pragma mark - Classify

- (NSArray<NSArray *> *)hsy_elementClassifyForKeyPath:(NSString *)keyPath
{
    NSMutableArray<NSArray *> *dataSources = [[NSMutableArray alloc] init];
    NSMutableArray *copySelf = [NSMutableArray arrayWithArray:self];
    for (NSInteger i = 0; i < copySelf.count; i ++) {
        id iObject = copySelf[i];
        NSMutableArray *elements = [[NSMutableArray alloc] init];
        [elements addObject:iObject];
        for (NSInteger j = (i + 1); j < copySelf.count; j ++) {
            id jObject = copySelf[j];
            id iValue = ([keyPath isEqualToString:@"self"] ? iObject : [iObject valueForKeyPath:keyPath]);
            id jValue = ([keyPath isEqualToString:@"self"] ? jObject : [jObject valueForKeyPath:keyPath]);
            if([iValue isEqual:jValue]){
                [elements addObject:jObject];
                [copySelf removeObjectAtIndex:j];
                j -= 1;
            }
        }
        [dataSources addObject:[elements mutableCopy]];
    }
    return [dataSources mutableCopy];
}

- (NSArray<NSArray *> *)hsy_stringElementClassify
{
    return [self hsy_elementClassifyForKeyPath:@"self"];
}

- (NSArray<NSArray *> *)hsy_numberElementClassify
{
    return [self hsy_elementClassifyForKeyPath:@"self"];
}

- (NSMutableArray *)hsy_elementClassify:(NSInteger)forCount
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSMutableArray *copys = [self mutableCopy];
    NSInteger count = (self.count / forCount) + 1;
    if ((self.count % forCount) == 0) {
        count --;
    }
    for (NSInteger i = 0; i < count; i ++) {
        NSMutableArray *subResults = [NSMutableArray arrayWithCapacity:forCount];
        for (NSInteger j = 0; j < copys.count; j ++) {
            [subResults addObject:copys[j]];
            [copys removeObjectAtIndex:j];
            j -= 1;
            if (subResults.count % forCount == 0) {
                break;
            }
        }
        [results addObject:subResults];
    }
    return results;
}

@end
