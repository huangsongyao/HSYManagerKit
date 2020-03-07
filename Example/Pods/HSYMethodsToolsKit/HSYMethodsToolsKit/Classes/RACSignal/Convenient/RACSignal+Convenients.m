//
//  RACSignal+Convenients.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "RACSignal+Convenients.h"

@implementation RACSignal (Convenients)

#pragma mark - Create Signals

+ (RACSignal<RACTuple *> *)hsy_sendTupleSignal:(nullable RACTuple *)tuple
{
    return [RACSignal hsy_sendObjectSignal:tuple];
}

+ (RACSignal<RACTuple *> *)hsy_sendTupleSignal:(nullable RACTuple *)tuple afterDelays:(NSTimeInterval)delays
{
    return [RACSignal hsy_sendObjectSignal:tuple afterDelays:delays];
}

+ (RACSignal *)hsy_sendObjectSignal:(nullable id)object
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber> subscriber) {
        [subscriber sendNext:object];
        [subscriber sendCompleted];
    }];
}

+ (RACSignal *)hsy_sendObjectSignal:(nullable id)object afterDelays:(NSTimeInterval)delays
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:object];
        [subscriber sendCompleted];
    } afterDelays:delays];
}

+ (RACSignal *)hsy_signalSubscriber:(void(^)(id<RACSubscriber> subscriber))didSubscriber
{
    return [RACSignal hsy_signalSubscriber:didSubscriber afterDelays:0.0f];
}

+ (RACSignal *)hsy_signalSubscriber:(void(^)(id<RACSubscriber> subscriber))didSubscriber afterDelays:(NSTimeInterval)delays 
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        if (didSubscriber) {
            [[RACScheduler mainThreadScheduler] afterDelay:delays schedule:^{
                didSubscriber(subscriber);
            }];
        }
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release cool signal methods ”+ signalSubscribe:“ in %@ class", self.class);
        }];
    }];
}

#pragma mark - Send Error

+ (RACSignal<NSError *> *)hsy_sendErrorSignal:(NSError *)error
{
    return [RACSignal hsy_sendErrorSignal:error afterDelays:0.0f];
}

+ (RACSignal<NSError *> *)hsy_sendErrorSignal:(NSError *)error afterDelays:(NSTimeInterval)delays
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendError:error];
    } afterDelays:delays];
}

#pragma mark - Performs

- (RACDisposable *)hsy_performCompletedSignal
{
    return [[self deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{}];
}

+ (RACSignal *)hsy_sendCompletedSignal
{
    return [RACSignal hsy_sendCompletedSignal:0.0f];
}

+ (RACSignal *)hsy_sendCompletedSignal:(NSTimeInterval)delays
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendCompleted];
    } afterDelays:delays];
}

+ (void)hsy_performSendSignal:(id<RACSubscriber>)subscriber forObject:(id)signal
{
    if ([subscriber conformsToProtocol:@protocol(RACSubscriber)]) {
        [subscriber sendNext:signal];
        [subscriber sendCompleted];
    }
}

#pragma mark - Then Signals

- (RACSignal<RACTuple *> *)hsy_thenSignal:(RACSignal *)signal
{
    @weakify(self);
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        [[self deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *  _Nullable firstResponse) {
            if ([firstResponse.first boolValue]) {
                [[signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable secondResponse) {
                    [subscriber sendNext:RACTuplePack(firstResponse, secondResponse)];
                    [subscriber sendCompleted];
                }];
                return;
            }
            [subscriber sendNext:RACTuplePack(firstResponse)];
            [subscriber sendCompleted];
        }];
    }];
}


@end
