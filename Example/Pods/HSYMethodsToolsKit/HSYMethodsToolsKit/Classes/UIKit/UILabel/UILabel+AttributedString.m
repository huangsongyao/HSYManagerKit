//
//  UILabel+AttributedString.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "UILabel+AttributedString.h"

@implementation UILabel (AttributedString)

+ (NSMutableAttributedString *)hsy_setLabelRTFAttributedDictionary:(NSDictionary *)attributedDictionary
                                                  attributedString:(NSString *)attributedString
                                                             range:(NSRange)range
{
    if (!attributedDictionary ||
        !attributedString ||
        range.length == 0) {
        return nil;
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:attributedString];
    for (NSInteger i = 0; i < attributedDictionary.allKeys.count; i ++) {
        NSString *key = attributedDictionary.allKeys[i];
        NSString *value = attributedDictionary[key];
        [attributedStr addAttribute:key
                              value:value
                              range:range];
    }
    return attributedStr;
}

- (void)hsy_setAttributed:(NSDictionary *)attributedDictionary attributedString:(NSString *)attributedString range:(NSRange)range
{
    self.attributedText = [UILabel hsy_setLabelRTFAttributedDictionary:attributedDictionary
                                                      attributedString:attributedString
                                                                 range:range];
}

@end
