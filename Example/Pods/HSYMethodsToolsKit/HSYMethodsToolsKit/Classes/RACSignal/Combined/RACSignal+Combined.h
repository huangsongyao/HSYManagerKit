//
//  RACSignal+Combined.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal (Combined)

/**
 返回合并zip信号的结果信号，signal为一个包含了RACTuple元组作为原生的list，该RACTuple元组的first表示next信号的x值，secondBlock表示errorBlock信号的error值

 @param signals 信号集
 @return zip信号
 */
+ (RACSignal<NSArray<RACTuple *> *> *)hsy_zipSignals:(NSArray<RACSignal *> *)signals;

@end

NS_ASSUME_NONNULL_END
