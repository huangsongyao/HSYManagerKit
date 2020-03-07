//
//  NSArray+GridsAlgorithm.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2020/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (GridsAlgorithm)

/// 获取list的总显示行数
/// @param unilineCounts 每行最多显示的个数
- (NSInteger)hsy_lines:(NSInteger)unilineCounts;

/// 获取总个数为allCounts的总显示行数
/// @param unilineCounts 每行最多显示的个数
/// @param allCounts 总个数
+ (NSInteger)hsy_lines:(NSInteger)unilineCounts byAllCounts:(NSInteger)allCounts;

/// 获取list的指定位置为index的元素所在的列数，该列数范围为：[1, unilineCounts]
/// @param unilineCounts 每行最多显示的个数
/// @param index 该元素在list中的位置
- (NSInteger)hsy_columns:(NSInteger)unilineCounts forIndex:(NSInteger)index;

/// 获取index位置的元素在整个集合中所在的列数，该列数范围为：[1, unilineCounts]
/// @param unilineCounts 每行最多显示的个数
/// @param index 该元素在list中的位置
+ (NSInteger)hsy_columns:(NSInteger)unilineCounts forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
