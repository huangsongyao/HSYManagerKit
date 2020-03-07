//
//  NSArray+Finder.m
//  FBSnapshotTestCase
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSArray+Finder.h"

NSInteger const kDefaultFindFailureIndex = -20181212;

@implementation NSArray (Finder)

- (NSInteger)hsy_finderObject:(id)object
{
    for (id obj in self) {
        if ([obj isEqual:object]) {
            return [self indexOfObject:obj];
        }
    }
    return kDefaultFindFailureIndex;
}

- (BOOL)hsy_objectIsExist:(id)object
{
    NSInteger i = [self hsy_finderObject:object];
    return (i != kDefaultFindFailureIndex);
}

- (NSInteger)hsy_finderObjectIndex:(id)object
{
    NSInteger i = [self hsy_finderObject:object];
    if (i == kDefaultFindFailureIndex) {
        i = 0;
    }
    return i;
}

@end

@implementation NSArray (JSON)

- (NSData *)hsy_toJSONData
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    return data;
}

@end
