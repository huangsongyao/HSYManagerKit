//
//  NSArray+GridsAlgorithm.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2020/1/7.
//

#import "NSArray+GridsAlgorithm.h"

@implementation NSArray (GridsAlgorithm)

- (NSInteger)hsy_lines:(NSInteger)unilineCounts
{
    return [NSArray hsy_lines:unilineCounts byAllCounts:self.count];
}

+ (NSInteger)hsy_lines:(NSInteger)unilineCounts byAllCounts:(NSInteger)allCounts
{
    NSInteger alls = allCounts;
    NSInteger lines = (((alls - 1) / unilineCounts) + 1);
    return ABS(lines);
}

- (NSInteger)hsy_columns:(NSInteger)unilineCounts forIndex:(NSInteger)index
{
    return [NSArray hsy_columns:unilineCounts forIndex:index];
}

+ (NSInteger)hsy_columns:(NSInteger)unilineCounts forIndex:(NSInteger)index
{
    NSInteger lines = [NSArray hsy_lines:unilineCounts byAllCounts:(index + 1)];
    NSInteger columns = ((index - ((lines - 1) * unilineCounts)) + 1);
    return ABS(columns);
}

@end
