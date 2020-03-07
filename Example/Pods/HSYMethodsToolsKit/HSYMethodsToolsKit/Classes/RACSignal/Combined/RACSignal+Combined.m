//
//  RACSignal+Combined.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import "RACSignal+Combined.h"
#import "RACSignal+Convenients.h"
#import "NSError+Message.h"
#import "NSObject+Property.h"

static NSString *kHSYMethodsToolsSignalIndexForKey = @"HSYMethodsToolsSignalIndexForKey";

@interface RACSignal (PrivatedProperty)

//私有category属性，用于记录当次zip中signal的位置
@property (nonatomic, strong) NSNumber *hsy_signalIndex;

@end

@implementation RACSignal (PrivatedProperty)

- (NSNumber *)hsy_signalIndex
{
    return [self hsy_getPropertyForKey:kHSYMethodsToolsSignalIndexForKey];
}

- (void)setHsy_signalIndex:(NSNumber *)hsy_signalIndex
{
    [self hsy_setProperty:hsy_signalIndex forKey:kHSYMethodsToolsSignalIndexForKey objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyNonatomicStrong];
}

@end

@interface NSArray (PrivatedOfSignal)

/// 如果记录zip的signals返回的结果存入的数组的个数已经达到signals的count值，表示zip中所有的signal都执行完毕了[不管是成功还是失败]，此时需要调用这个私有方法，将zip的结果汇总回调到外部的监听器中
/// @param signalCounts zip的signals的数目
/// @param subscriber 信号发射器
- (BOOL)hsy_zipSignalsResult:(NSInteger)signalCounts withSubscriber:(id<RACSubscriber>)subscriber;

@end

@implementation NSArray (PrivatedOfSignal)

- (BOOL)hsy_zipSignalsResult:(NSInteger)signalCounts withSubscriber:(id<RACSubscriber>)subscriber
{
    if (self.count >= signalCounts) {
        [RACSignal hsy_performSendSignal:subscriber forObject:self];
        return YES;
    }
    return NO;
}

@end

@implementation RACSignal (Combined)

+ (RACSignal<NSArray<RACTuple *> *> *)hsy_zipSignals:(NSArray<RACSignal *> *)signals
{
    return [RACSignal hsy_signalSubscriber:^(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSMutableArray *results = [[NSMutableArray alloc] init];
        [signals enumerateObjectsUsingBlock:^(RACSignal * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @weakify(obj);
            obj.hsy_signalIndex = @(idx);
            [[obj deliverOn:[RACScheduler scheduler]] subscribeNext:^(id  _Nullable x) {
                @strongify(obj);
                [results addObject:RACTuplePack(x, nil, obj.hsy_signalIndex)];
            } error:^(NSError * _Nullable error) {
                @strongify(obj);
                [results addObject:RACTuplePack(nil, error, obj.hsy_signalIndex)];
                if ([results hsy_zipSignalsResult:signals.count withSubscriber:subscriber]) {
                    results = nil;
                }
            } completed:^{
                if ([results hsy_zipSignalsResult:signals.count withSubscriber:subscriber]) {
                    results = nil;
                }
            }];
        }];
    }];
}


@end
