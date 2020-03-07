//
//  UIView+Frame.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

- (CGPoint)origin;                                      //[x, y]坐标
- (CGFloat)x;                                           //x坐标
- (CGFloat)y;                                           //y坐标
- (CGFloat)right;                                       //x + w
- (CGFloat)bottom;                                      //y + h
- (CGFloat)mid_x;                                       //x + w/2
- (CGFloat)mid_y;                                       //y + h/2

- (CGFloat)height;                                      //高度
- (CGFloat)width;                                       //宽度
- (CGSize)size;                                         //视图size
- (CGFloat)ceilWidth;                                   //向下取整的宽度
- (CGFloat)ceilHeight;                                  //向下取整的高度度
- (CGSize)ceilSize;                                     //向下取整的视图size

- (void)setSize:(CGSize)size;                           //设置size
- (void)setWidth:(CGFloat)width;                        //设置宽度
- (void)setHeight:(CGFloat)height;                      //设置高度

- (void)setOrigin:(CGPoint)origin;                      //设置[x, y]坐标
- (void)setX:(CGFloat)x;                                //设置x坐标
- (void)setY:(CGFloat)y;                                //设置y坐标

/**
 origin为CGPointZero的初始化
 
 @param size size
 @return self
 */
- (instancetype)initWithSize:(CGSize)size;

/**
 origin为CGPointZero，height为0.0f的初始化
 
 @param width 宽度
 @return self
 */
- (instancetype)initWithWidth:(CGFloat)width;

/**
 origin为CGPointZero，width为0.0f的初始化
 
 @param height 高度
 @return self
 */
- (instancetype)initWithHeight:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
