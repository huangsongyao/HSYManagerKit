//
//  NSString+Replace.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSString+Replace.h"
#import "NSString+Regular.h"

@implementation NSString (Replace)

#pragma mark - Location For String

- (NSMutableArray<NSValue *> *)hsy_allSymbolLocations:(NSString *)symbol
{
    if (symbol.length == 0 || self.length == 0) {
        return nil;
    }
    NSMutableArray *arrayRanges = [[NSMutableArray alloc] init];
    NSRange rang = [self rangeOfString:symbol];
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSValue valueWithRange:NSMakeRange(rang.location, symbol.length)]];
        NSRange locationRang = {0, 0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (NSInteger i = 0;; i++) {
            if (0 == i) {
                location = rang.location + rang.length;
                length = self.length - rang.location - rang.length;
                locationRang = NSMakeRange(location, length);
            } else {
                location = locationRang.location + locationRang.length;
                length = self.length - locationRang.location - locationRang.length;
                locationRang = NSMakeRange(location, length);
            }
            locationRang = [self rangeOfString:symbol options:NSCaseInsensitiveSearch range:locationRang];
            if (locationRang.location == NSNotFound && locationRang.length == 0) {
                break;
            } else {
                NSValue *value = [NSValue valueWithRange:locationRang];
                [arrayRanges addObject:value];
            }
        }
        return arrayRanges;
    }
    return nil;
}

#pragma mark - Replace Crashed Unicode

- (NSString *)hsy_stringByReplaceSomeCrashedUnicode
{
    NSString *string = nil;
    if ([self canBeConvertedToEncoding:NSUTF8StringEncoding]) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return string;
}

#pragma mark - Replacing

- (NSString *)hsy_stringByReplacingOccurrences
{
    return [self hsy_stringByReplacingOccurrencesOfSymbol:@" "];
}

- (NSString *)hsy_stringByReplacingOccurrencesOfSymbol:(NSString *)symbol
{
    return [self stringByReplacingOccurrencesOfString:symbol withString:@""];
}

- (NSString *)hsy_stringByTrimmingCharacters
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - TecimalPlace Change To unit

+ (NSString *)hsy_unitFromDecimal:(NSInteger)decimal
{
    NSString *prefix = @"0.";
    for (NSInteger i = 0; i < (decimal - 1); i ++) {
        prefix = [NSString stringWithFormat:@"%@0", prefix];
    }
    prefix = [prefix stringByAppendingString:@"1"];
    return prefix;
}

#pragma mark - Replace Sections

- (NSArray<NSString *> *)hsy_replaceIncreasingSections:(NSInteger)index
{
    if (self.length <= index) {
        return @[self];
    }
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    NSInteger count = self.length / index;
    NSInteger location = 0;
    for (NSInteger i = 0; i < count; i ++) {
        NSString *subString = [self substringWithRange:NSMakeRange(location, index)];
        [sections addObject:subString];
        location += index;
    }
    if (self.length % index > 0) {
        NSString *lastSubString = [self substringFromIndex:location];
        [sections addObject:lastSubString];
    }
    return sections.mutableCopy;
}

- (NSArray<NSString *> *)hsy_replaceDiminishingSections:(NSInteger)index
{
    if (self.length <= index) {
        return @[self];
    }
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    NSInteger count = self.length / index;
    NSInteger location = (self.length - index);
    for (NSInteger i = 0; i < count; i ++) {
        NSString *subString = [self substringWithRange:NSMakeRange(location, index)];
        [sections addObject:subString];
        location -= index;
    }
    sections = [[sections reverseObjectEnumerator] allObjects].mutableCopy;
    if (self.length % index > 0) {
        NSString *firstSubString = [self substringToIndex:(self.length - (index * sections.count))];
        [sections insertObject:firstSubString atIndex:0];
    }
    return sections.mutableCopy;
}

#pragma mark - Format Moneys

- (NSString *)hsy_formattingByMoneys
{
    NSString *result = self.copy;
    if (!result.isPureNumber) {
        return result;
    }
    if ([result containsString:@","]) {
        return result;
    }
    NSInteger borderValue = 3;
    if ([self containsString:@"."]) {
        NSArray *formats = [self componentsSeparatedByString:@"."];
        NSString *firstObject = formats.firstObject;
        NSString *lastObject = formats.lastObject;
        if (firstObject.length > borderValue) {
            NSArray<NSString *> *groups = [firstObject hsy_replaceDiminishingSections:borderValue];
            NSString *prefix = [groups componentsJoinedByString:@","];
            result = [NSString stringWithFormat:@"%@.%@", prefix, lastObject];
        }
    } else if (self.length > borderValue) {
        NSArray<NSString *> *groups = [self hsy_replaceDiminishingSections:borderValue];
        result = [groups componentsJoinedByString:@","];
    } else {
        result = [NSString stringWithFormat:@"%.2f", result.doubleValue];
    }
    return result;
}

@end
