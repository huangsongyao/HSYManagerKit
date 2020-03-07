//
//  UILabel+SuggestSize.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "UILabel+SuggestSize.h"
#import "UIView+Frame.h"
#import "NSString+StringSize.h"

@implementation UILabel (SuggestSize)

- (void)hsy_setSuggestString:(NSString *)text
                   maxWidths:(CGFloat)widths
                        font:(UIFont *)font
               numberOfLines:(NSInteger)numberOfLines
               lineBreakMode:(NSLineBreakMode)lineBreakMode
               textAlignment:(NSTextAlignment)textAlignment
{
    self.font = font;
    self.text = text;
    self.textAlignment = textAlignment;
    self.numberOfLines = numberOfLines;
    self.lineBreakMode = lineBreakMode;
}

- (void)hsy_setSuggestString:(NSString *)text
                   maxWidths:(CGFloat)widths
                        font:(UIFont *)font
               textAlignment:(NSTextAlignment)textAlignment
{
    [self hsy_setSuggestString:text
                     maxWidths:widths
                          font:font
                 numberOfLines:0
                 lineBreakMode:NSLineBreakByCharWrapping
                 textAlignment:textAlignment];
    self.size = [self.text hsy_boundingRectWithWidths:widths
                                                 font:self.font];
}

- (void)hsy_alineSuggestString:(NSString *)text
                     maxWidths:(CGFloat)widths
                          font:(UIFont *)font
{
    [self hsy_setSuggestString:text
                     maxWidths:widths
                          font:font
                 numberOfLines:1
                 lineBreakMode:NSLineBreakByTruncatingTail
                 textAlignment:NSTextAlignmentLeft];
    CGSize size = [self.text hsy_boundingRectWithWidths:widths
                                                   font:self.font];
    self.width = size.width;
    self.height = font.lineHeight; 
}

@end
