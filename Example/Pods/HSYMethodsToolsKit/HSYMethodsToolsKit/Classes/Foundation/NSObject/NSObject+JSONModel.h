//
//  NSObject+JSONModel.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JSONModel)

/**
 利用json对象+JSONModel子类做动态解析

 @param json json对象
 @param classes JSONModel类族的类名
 @return 解析成功后，会返回一个用classes定义的JSONModel类族的对象，如果解析失败，则返回一个error错误信息
 */
+ (id)hsy_toJSONModel:(NSObject *)json forModelClasses:(Class)classes;

@end

NS_ASSUME_NONNULL_END
