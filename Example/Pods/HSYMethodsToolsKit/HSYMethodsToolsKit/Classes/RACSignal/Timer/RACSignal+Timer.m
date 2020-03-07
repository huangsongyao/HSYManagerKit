//
//  RACSignal+Timer.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "RACSignal+Timer.h"

@implementation RACSignal (Timer)

+ (RACDisposable *)hsy_timerSignal:(NSTimeInterval)intervals
                 timerMaxIntervals:(NSTimeInterval)maxIntervals
                     subscribeNext:(BOOL(^)(NSDate *date, NSTimeInterval interval))next
{
    static NSTimeInterval currentIntervals = 0.0f;
    __block RACDisposable *disposable = nil;
    disposable = [[RACSignal interval:intervals onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0.000001f] subscribeNext:^(NSDate *date) {
        currentIntervals += intervals;
        if (next) {
            BOOL stop = next(date, currentIntervals);
            if (stop && (currentIntervals >= maxIntervals)) {
                currentIntervals = 0.0f;
                [disposable dispose];
                disposable = nil;
            }
        }
    }];
    return disposable;
}

+ (RACDisposable *)hsy_timerSignal:(NSTimeInterval)maxIntervals
                     subscribeNext:(BOOL(^)(NSDate *date, NSTimeInterval interval))next
{
    return [self.class hsy_timerSignal:1.0f
                     timerMaxIntervals:maxIntervals
                         subscribeNext:next];
}

@end
