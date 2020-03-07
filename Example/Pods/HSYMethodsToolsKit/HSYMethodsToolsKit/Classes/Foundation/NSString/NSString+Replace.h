//
//  NSString+Replace.h
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Replace)

/**
 获取字符串中所有特殊占位符的位置
 
 @param symbol 占位符
 @return 占位符的位置的集合
 */
- (NSMutableArray<NSValue *> *)hsy_allSymbolLocations:(NSString *)symbol;

/**
 过滤字符串中的unicode表情
 
 @return 过滤后的字符串
 */
- (NSString *)hsy_stringByReplaceSomeCrashedUnicode;

/**
 去除字符串首尾的空格
 
 @return 过滤后的字符串
 */
- (NSString *)hsy_stringByTrimmingCharacters;

/**
 过滤字符串中所有的空格符
 
 @return 无空格符的字符串
 */
- (NSString *)hsy_stringByReplacingOccurrences;

/**
 过滤字符串中的特殊字符，并使用空字符串替代
 
 @param symbol 要过滤的特殊字符
 @return 无特殊字符的字符串
 */
- (NSString *)hsy_stringByReplacingOccurrencesOfSymbol:(NSString *)symbol;

/**
 将小数点后保留的位数转为精度位数的单位，例如：decimal = 5，则结果为：0.00001
 
 @param decimal 小数点后保留的位数
 @return 例如：decimal = 5，则结果为：0.00001
 */
+ (NSString *)hsy_unitFromDecimal:(NSInteger)decimal;

/**
 通过index的位置，逐一截取，例如对字符串@"123456789"执行逐一截取，index为2，则返回@[@"12", @"34", @"56", @"78", @"9"]，属于正向递增
 
 @param index 逐一截取的位置
 @return 正向逐一截取的集合
 */
- (NSArray<NSString *> *)hsy_replaceIncreasingSections:(NSInteger)index;

/**
 通过index的位置，逐一截取，例如对字符串@"123456789"执行逐一截取，index为2，则返回@[@"1", @"23", @"45", @"67", @"89"]，属于反向递减

 @param index 逐一截取的位置
 @return 返向逐一截取的集合
 */
- (NSArray<NSString *> *)hsy_replaceDiminishingSections:(NSInteger)index;

/**
 金额格式化，保留小数点后2位，格式类型为：1000 -> 1,000.00 | 45 -> 45.00 | 133333 -> 133,333.00 | 12.9 -> 12.90

 @return 金额格式化，保留小数点后2位
 */
- (NSString *)hsy_formattingByMoneys;

@end

NS_ASSUME_NONNULL_END
