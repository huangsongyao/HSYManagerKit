//
//  NSDictionary+JSON.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "NSDictionary+JSON.h"
#import "NSString+Replace.h"

@implementation NSDictionary (JSON)

- (NSString *)hsy_toJSONString
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].hsy_stringByReplacingOccurrences;
    return jsonString;
}

@end

