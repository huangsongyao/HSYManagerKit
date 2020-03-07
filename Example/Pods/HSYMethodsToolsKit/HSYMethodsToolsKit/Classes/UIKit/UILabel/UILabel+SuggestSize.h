//
//  UILabel+SuggestSize.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SuggestSize)

/**
 动态设置UILabel的多行显示size

 @param text 文本内容
 @param widths 最大显示宽度
 @param font 字号
 @param textAlignment 文本对齐方式
 */
- (void)hsy_setSuggestString:(NSString *)text
                   maxWidths:(CGFloat)widths
                        font:(UIFont *)font
               textAlignment:(NSTextAlignment)textAlignment;

/**
 动态设置UILabel的单行显示宽度，如果超过最大显示宽度的widths时，会显示"..."结尾

 @param text 文本内容
 @param widths 最大显示宽度
 @param font 字号
 */
- (void)hsy_alineSuggestString:(NSString *)text
                     maxWidths:(CGFloat)widths
                          font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
