//
//  UIView+Rotated.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const kHSYMethodsToolsViewRotationsForKey;
typedef void(^HSYRotationsCompleted)(CAAnimation *animation);

@interface UIView (Rotated) <CAAnimationDelegate>

@property (nonatomic, copy) HSYRotationsCompleted rotationCompleted;

/**
 手动停止绕圆心的旋转动画
 */
- (void)hsy_stopRotated;

/**
 开启一个绕圆心的旋转动画，过程为绕圆心旋转，次数为无限次，每次动画时间为1s
 */
- (void)hsy_rotateds;

/**
 开启一个绕圆心的旋转动画，过程为绕圆心旋转，次数为无限次，每次动画时间为1s，动画结束后由completed返回动画结束
 
 @param completed 动画结束后的回调
 */
- (void)hsy_rotateds:(HSYRotationsCompleted)completed;

/**
 开启一个绕圆心的旋转动画，过程为绕圆心旋转，次数为repeat，每次动画时间为1s
 
 @param repeat 完整动画的次数
 */
- (void)hsy_rotatedsRepeat:(NSInteger)repeat;

/**
 开启一个绕圆心的旋转动画，过程为绕圆心旋转，次数为repeat，每次动画时间为1s，动画结束后由completed返回动画结束
 
 @param repeat 完整动画的次数
 @param completed 动画结束后的回调
 */
- (void)hsy_rotatedsRepeat:(NSInteger)repeat completed:(HSYRotationsCompleted)completed;

/**
 开启一个绕圆心的旋转动画，过程为绕圆心旋转，次数为无限次，每次动画时间为duration秒，动画结束后由completed返回动画结束
 
 @param duration 绕圆心转动单次动画的时间
 @param completed 动画结束后的回调
 */
- (void)hsy_rotateds:(NSTimeInterval)duration completed:(HSYRotationsCompleted)completed;

/**
 开启一个绕圆心的旋转动画，过程为绕圆心旋转，次数为无限次，每次动画时间为duration秒，动画结束后由completed返回动画结束，添加至layer层的动画key为key
 
 @param duration 绕圆心转动单次动画的时间
 @param key 添加至layer层的动画key
 @param completed 动画结束后的回调
 */
- (void)hsy_rotateds:(NSTimeInterval)duration forKey:(NSString *)key completed:(HSYRotationsCompleted)completed;

/**
 开启一个绕圆心的旋转动画，过程为绕圆心旋转，次数为repeat次，每次动画时间为duration秒，动画结束后由completed返回动画结束，添加至layer层的动画key为key
 
 @param duration 绕圆心转动单次动画的时间
 @param repeat 完整动画的次数
 @param key 添加至layer层的动画key
 @param completed 动画结束后的回调
 */
- (void)hsy_rotateds:(NSTimeInterval)duration repeatCount:(NSInteger)repeat forKey:(NSString *)key completed:(HSYRotationsCompleted)completed;


@end

NS_ASSUME_NONNULL_END
