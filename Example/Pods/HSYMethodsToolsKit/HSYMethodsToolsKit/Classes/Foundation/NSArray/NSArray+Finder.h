//
//  NSArray+Finder.h
//  FBSnapshotTestCase
//
//  Created by huangsongyao on 2019/9/26.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSInteger const kDefaultFindFailureIndex;

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Finder)

/**
 如果Object属于数组的元素，则返回该元素在数组中的位置，否则返回特定值kDefaultFindFailureIndex
 
 @param object Object
 @return 位置
 */
- (NSInteger)hsy_finderObject:(id)object;

/**
 判断Object是否为数组的元素
 
 @param object Object
 @return 是否为数组的成员元素
 */
- (BOOL)hsy_objectIsExist:(id)object;

/**
 如果Object属于数组的元素，则返回该元素在数组中的位置，否则返回0
 
 @param object Object
 @return 位置
 */
- (NSInteger)hsy_finderObjectIndex:(id)object;

@end

@interface NSArray (JSON)

/**
 NSArray JSON 转 NSData JSON
 
 @return NSData JSON
 */
- (NSData *)hsy_toJSONData;

@end

NS_ASSUME_NONNULL_END
