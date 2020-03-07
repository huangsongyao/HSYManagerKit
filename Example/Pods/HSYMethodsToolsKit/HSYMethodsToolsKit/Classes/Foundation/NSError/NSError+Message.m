//
//  NSError+Message.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import "NSError+Message.h"

FOUNDATION_EXPORT NSErrorDomain const kHSYMethodsToolsKitJSOMModelErrorDomain;
NSErrorDomain const kHSYMethodsToolsKitJSOMModelErrorDomain = @"HSYMethodsToolsKitJSOMModelErrorDomain";
NSErrorUserInfoKey const kHSYMethodsToolsKitJSOMModelErrorKey = @"HSYMethodsToolsKitJSOMModelErrorKey";

FOUNDATION_EXPORT NSErrorDomain const kHSYMethodsToolsKitRACSignalErrorDomain;
NSErrorDomain const kHSYMethodsToolsKitRACSignalErrorDomain = @"HSYMethodsToolsKitRACSignalErrorDomain";
NSErrorUserInfoKey const kHSYMethodsToolsKitRACSignalErrorKey = @"HSYMethodsToolsKitRACSignalErrorKey";

@implementation NSError (Message)

+ (NSError *)hsy_defaultJSONModelErrorMessage
{
    NSError *error = [[NSError alloc] initWithDomain:kHSYMethodsToolsKitJSOMModelErrorDomain
                                                code:kHSYMethodsToolsKitErrorCode
                                            userInfo:@{kHSYMethodsToolsKitJSOMModelErrorKey : @"JSONModel解析报错，出错原因可能为json数据为nil或解析的json对象不是[NSDictionary或NSArray]！请检查"}];
    return error;
}

+ (NSError *)hsy_defaultRACSignalErrorMessage
{
    NSError *error = [[NSError alloc] initWithDomain:kHSYMethodsToolsKitRACSignalErrorDomain
                                                code:kHSYMethodsToolsKitRACSignalErrorCode
                                            userInfo:@{kHSYMethodsToolsKitRACSignalErrorKey : @"RACSignal category methods -> [+ (RACSignal<RACTuple *> *)hsy_zipSignals:(NSArray<RACSignal *> *)signals] default error message"}];
    return error;
}

@end
