//
//  NSString+StringSize.h
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (StringSize)

/**
 计算字符串的显示区域

 @param maxSize 最大显示宽度和最大显示高度
 @param font 字体字号
 @param string 字符串内容
 @return 字符串的显示区域
 */
+ (CGSize)hsy_boundingRectWithSize:(CGSize)maxSize font:(UIFont *)font forString:(NSString *)string;

/**
 计算self字符串的显示区域

 @param maxSize 最大显示宽度和最大显示高度
 @param font 字体字号
 @return 字符串的显示区域
 */
- (CGSize)hsy_boundingRectWithSize:(CGSize)maxSize font:(UIFont *)font;

/**
 计算self字符串在固定最大显示宽度为widths后，计算出的显示区域

 @param widths self字符串的最大显示宽度
 @param font 字体字号
 @return 字符串的显示区域
 */
- (CGSize)hsy_boundingRectWithWidths:(CGFloat)widths font:(UIFont *)font;

/**
 计算self字符串在固定最大显示高度为heights后，计算出的显示区域

 @param heights self字符串的最大显示高度
 @param font 字体字号
 @return 字符串的显示区域
 */
- (CGSize)hsy_boundingRectWithHeights:(CGFloat)heights font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
