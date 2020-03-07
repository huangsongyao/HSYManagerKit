//
//  UILabel+AttributedString.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AttributedString)

/**
 *  富文本
 *
 *  @param attributedDictionary    富文本设置的相关数据，格式为：@{ NSForegroundColorAttributeName : THEME_COLOR, NSFontAttributeName : TITLE_FONT, }
 *  @param attributedString 重组后的字符串
 *  @param range            实现富文本效果的NSRang位置
 *
 *  @return NSAttributedString
 */
+ (NSMutableAttributedString *)hsy_setLabelRTFAttributedDictionary:(NSDictionary *)attributedDictionary
                                                  attributedString:(NSString *)attributedString
                                                             range:(NSRange)range;

/**
 label实现富文本
 
 @param attributedDictionary @{NSForegroundColorAttributedName : UIColor.white, ... }
 @param attributedString 完整的文本内容
 @param range 富文本的NSRange位置
 */
- (void)hsy_setAttributed:(NSDictionary *)attributedDictionary
         attributedString:(NSString *)attributedString
                    range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
