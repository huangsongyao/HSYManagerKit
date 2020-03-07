//
//  NSDictionary+JSON.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JSON)

/**
 键值对转为JSON字符串

 @return JSON字符串
 */
- (NSString *)hsy_toJSONString;

@end

NS_ASSUME_NONNULL_END
