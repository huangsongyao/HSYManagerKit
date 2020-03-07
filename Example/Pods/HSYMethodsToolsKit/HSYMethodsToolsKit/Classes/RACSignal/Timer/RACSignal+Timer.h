//
//  RACSignal+Timer.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal (Timer)

/**
 返回一个线程计时器

 @param intervals 计时器触发间隔时间
 @param maxIntervals 计时器最大边界时间
 @param next 计时器触发事件回调事件，next的block会返回一个BOOL值，YES表示当计时器的计时时间大于等于边界时间maxIntervals，会停止这个线程计时器，否则不停止
 @return RACDisposable
 */
+ (RACDisposable *)hsy_timerSignal:(NSTimeInterval)intervals
                 timerMaxIntervals:(NSTimeInterval)maxIntervals
                     subscribeNext:(BOOL(^)(NSDate *date, NSTimeInterval interval))next;

/**
 返回一个线程计时器，间隔触发时间1.0s

 @param maxIntervals 计时器最大边界时间
 @param next 计时器触发事件回调事件
 @return RACDisposable，next的block会返回一个BOOL值，YES表示当计时器的计时时间大于等于边界时间maxIntervals，会停止这个线程计时器，否则不停止
 */
+ (RACDisposable *)hsy_timerSignal:(NSTimeInterval)maxIntervals
                     subscribeNext:(BOOL(^)(NSDate *date, NSTimeInterval interval))next;

@end

NS_ASSUME_NONNULL_END
