//
//  RACSignal+Convenients.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal (Convenients)

#pragma mark - Create Signals

/**
 创建一个信号管道，用于将RACTuple元组包装成冷信号，并发送出去，不延迟发送

 @param tuple RACTuple元组包装的冷信号
 @return RACSignal<RACTuple *> *
 */
+ (RACSignal<RACTuple *> *)hsy_sendTupleSignal:(nullable RACTuple *)tuple;

/**
 创建一个信号管道，用于将RACTuple元组包装成冷信号，并发送出去，会延迟发送，延迟时间为delays

 @param tuple RACTuple元组包装的冷信号
 @param delays 延迟发送时间时间
 @return RACSignal<RACTuple *> *
 */
+ (RACSignal<RACTuple *> *)hsy_sendTupleSignal:(nullable RACTuple *)tuple afterDelays:(NSTimeInterval)delays;

/**
 创建一个信号管道，用于将id类型包装成冷信号，并发送出去，不延迟发送

 @param object 冷信号
 @return RACSignal *
 */
+ (RACSignal *)hsy_sendObjectSignal:(nullable id)object;

/**
 创建一个信号管道，用于将id类型包装成冷信号，并发送出去，会延迟发送，延迟时间为delays

 @param object 冷信号
 @param delays 延迟发送时间时间
 @return RACSignal *
 */
+ (RACSignal *)hsy_sendObjectSignal:(nullable id)object afterDelays:(NSTimeInterval)delays;

/**
 快速创建一个冷信号管道，并发送出去，不延迟发送

 @param didSubscriber 信号管道
 @return RACSignal *
 */
+ (RACSignal *)hsy_signalSubscriber:(void(^)(id<RACSubscriber> subscriber))didSubscriber;

/**
 快速创建一个冷信号管道，并发送出去，会延迟发送，延迟时间为delays

 @param didSubscriber 信号管道
 @param delays 延迟发送时间时间
 @return RACSignal *
 */
+ (RACSignal *)hsy_signalSubscriber:(void(^)(id<RACSubscriber> subscriber))didSubscriber afterDelays:(NSTimeInterval)delays;

#pragma mark - Send Error

/**
 创建一个管道来快速发送一个error冷信号

 @param error 错误信息
 @return RACSignal<NSError *> *
 */
+ (RACSignal<NSError *> *)hsy_sendErrorSignal:(NSError *)error;

/// 创建一个管道，延迟delays秒后来快速发送一个error冷信号
/// @param error 错误信息
/// @param delays RACSignal<NSError *> *
+ (RACSignal<NSError *> *)hsy_sendErrorSignal:(NSError *)error afterDelays:(NSTimeInterval)delays;

#pragma mark - Performs

/**
 让RACSignal的信号对象立即执行completed完成信号

 @return RACDisposable *
 */
- (RACDisposable *)hsy_performCompletedSignal;

/**
 创建一个RACSignal对象，并立即执行completed完成信号

 @return RACSignal
 */
+ (RACSignal *)hsy_sendCompletedSignal;

/**
 创建一个RACSignal对象，延迟delays时间执行completed完成信号

 @param delays 延迟执行的时间
 @return RACSignal
 */
+ (RACSignal *)hsy_sendCompletedSignal:(NSTimeInterval)delays;

/**
 对RACSubscriber协议对象增加sendNext:之后执行sendCompleted
 
 @param subscriber id<RACSubscriber>
 @param signal sendNext:方法的参数
 */
+ (void)hsy_performSendSignal:(id<RACSubscriber>)subscriber forObject:(id)signal;

#pragma mark - Then Signals

/**
 重定义then类型的信号合并方式
 规则为：self需要返回一个RACTuple元组，而该元组的first必须为BOOL型的NSNumber，如果self这个信号回的RACTuple满足 -> tuple.first == @(YES)，则执行signal信号并等待signal信号的结果，最后统一包装成一个RACTuple元组[格式为:RACTuplePack(firstResponse, secondResponse)]；否则如果不满足-> tuple.first == @(YES)，则返回self这个信号的结果所包装成的一个RACTuple元组[格式为:RACTuplePack(firstResponse)]

 @param signal then的另一个信号
 @return RACSignal<RACTuple *> *
 */
- (RACSignal<RACTuple *> *)hsy_thenSignal:(RACSignal *)signal;

@end

NS_ASSUME_NONNULL_END
