//
//  NSString+StringSize.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSString+StringSize.h"
#import <UIKit/UIKit.h>

@implementation NSString (StringSize)

+ (CGSize)hsy_boundingRectWithSize:(CGSize)maxSize font:(UIFont *)font forString:(NSString *)string
{
    if (!string.length || !font) {
        return CGSizeZero;
    }
    CGFloat heights = (maxSize.height > 0.0f ? maxSize.height : MAXFLOAT);
    CGFloat widths = (maxSize.width > 0.0f ? maxSize.width : 100);
    NSDictionary *paramters = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(widths, heights)
                                options:(NSStringDrawingTruncatesLastVisibleLine |
                                         NSStringDrawingUsesLineFragmentOrigin |
                                         NSStringDrawingUsesFontLeading)
                             attributes:paramters
                                context:nil].size;
}

- (CGSize)hsy_boundingRectWithSize:(CGSize)maxSize font:(UIFont *)font
{
    return [NSString hsy_boundingRectWithSize:maxSize font:font forString:self];
}

- (CGSize)hsy_boundingRectWithWidths:(CGFloat)widths font:(UIFont *)font
{
    return [NSString hsy_boundingRectWithSize:CGSizeMake(widths, 0.0f) font:font forString:self];
}

- (CGSize)hsy_boundingRectWithHeights:(CGFloat)heights font:(UIFont *)font
{
    return [NSString hsy_boundingRectWithSize:CGSizeMake(0.0f, heights) font:font forString:self];
}

@end
