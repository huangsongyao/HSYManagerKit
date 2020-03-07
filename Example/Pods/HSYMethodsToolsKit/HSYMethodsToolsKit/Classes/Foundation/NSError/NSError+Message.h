//
//  NSError+Message.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorUserInfoKey const kHSYMethodsToolsKitJSOMModelErrorKey;
static const NSInteger kHSYMethodsToolsKitErrorCode = 20181212;

FOUNDATION_EXPORT NSErrorUserInfoKey const kHSYMethodsToolsKitRACSignalErrorKey;
static const NSInteger kHSYMethodsToolsKitRACSignalErrorCode = 19930205;

@interface NSError (Message)

/**
 返回一个JSONModel解析出错后的默认message

 @return JSONModel解析出错后的默认message
 */
+ (NSError *)hsy_defaultJSONModelErrorMessage;

/**
 返回一个RACSignal的Category的+ (RACSignal<RACTuple *> *)hsy_zipSignals:(NSArray<RACSignal *> *)signals方法的默认报错

 @return NSError
 */
+ (NSError *)hsy_defaultRACSignalErrorMessage;

@end

NS_ASSUME_NONNULL_END
