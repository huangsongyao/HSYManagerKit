//
//  UIViewController+Load.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *kHSYMethodsToolsKitRuntimeObjectClass;
FOUNDATION_EXPORT kHSYMethodsToolsKitRuntimeObjectClass const hsyObject;
FOUNDATION_EXPORT kHSYMethodsToolsKitRuntimeObjectClass const hsyDictionary;
FOUNDATION_EXPORT kHSYMethodsToolsKitRuntimeObjectClass const hsyArray;
FOUNDATION_EXPORT kHSYMethodsToolsKitRuntimeObjectClass const hsyNumber;
FOUNDATION_EXPORT kHSYMethodsToolsKitRuntimeObjectClass const hsyString;

@interface UIViewControllerRuntimeObject : NSObject

@property (nonatomic, strong) id object;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, copy) NSString *string;

+ (instancetype)initWithDictionary:(NSDictionary<kHSYMethodsToolsKitRuntimeObjectClass, id> *)dictionary;

@end

@protocol UIViewControllerRuntimeDelegate <NSObject>

- (void)hsy_runtimeDelegate:(UIViewControllerRuntimeObject *)object;

@end

@interface UIViewController (Load)

//controller的全局委托
@property (nonatomic, weak) id<UIViewControllerRuntimeDelegate>hsy_runtimeDelegate;

@end

NS_ASSUME_NONNULL_END
