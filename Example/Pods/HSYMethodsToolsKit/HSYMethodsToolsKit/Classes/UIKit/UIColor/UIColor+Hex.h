//
//  UIColor+Hex.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

@property (nonatomic, readonly) CGColorSpaceModel   colorSpaceModel;

@property (nonatomic, readonly) BOOL                canProvideRGBComponents;
@property (nonatomic, readonly) UInt32              rgbHex;

@property (nonatomic, readonly) CGFloat red;    // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green;  // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue;   // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white;  // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;

+ (UIColor *)hsy_colorWithRGBHex:(UInt32)hex;
+ (UIColor *)hsy_colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;
+ (UIColor *)hsy_colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)hsy_colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

- (BOOL)hsy_red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a;
- (NSString *)hsy_hexStringFromColor;

+ (UIColor *)hsy_colorWithHex:(long)hexColor;
+ (UIColor *)hsy_colorWithHex:(long)hexColor alpha:(CGFloat)opacity;

@end

NS_ASSUME_NONNULL_END
