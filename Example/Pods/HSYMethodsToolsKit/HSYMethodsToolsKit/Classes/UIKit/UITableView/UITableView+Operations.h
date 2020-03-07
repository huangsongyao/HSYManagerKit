//
//  UITableView+Operations.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Operations)

/**
 在Section=0和Row=0处插入，动画过度类型为UITableViewRowAnimationBottom
 */
- (void)hsy_firstInsertSectionRow;

/**
 在Section=0和Row=0处删除，动画过度类型为UITableViewRowAnimationBottom
 */
- (void)hsy_firstDeleteSectionRow;

/**
 在section=0初的任意row位置插入数据，，动画过度类型为UITableViewRowAnimationBottom

 @param rows section=0初的任意row位置
 */
- (void)hsy_insertSection:(NSInteger)rows;

/**
 在section=0初的任意row位置删除数据，，动画过度类型为UITableViewRowAnimationBottom
 
 @param rows section=0初的任意row位置
 */
- (void)hsy_deleteSection:(NSInteger)rows;

@end

NS_ASSUME_NONNULL_END
