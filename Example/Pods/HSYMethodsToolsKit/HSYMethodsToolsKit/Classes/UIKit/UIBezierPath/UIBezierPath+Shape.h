//
//  UIBezierPath+Shape.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (Shape)

/**
 绘制贝塞尔路径，并返回路径绘制后的layer
 
 @param beziers 贝塞尔路径的路径坐标点集合
 @param lineWidth 路径的线条宽度
 @param strokeColor 路径线条的颜色
 @param fillColor 由路径围起来的区域的填充色
 @param lineJoin 贝塞尔路径拐点的类型：kCALineJoinMiter->直角，kCALineJoinRound->圆角，kCALineJoinBevel ->无角
 @return CAShapeLayer
 */
+ (CAShapeLayer *)hsy_BezierPath:(NSArray<NSValue *> *)beziers
                       lineWidth:(CGFloat)lineWidth
                     strokeColor:(UIColor *)strokeColor
                       fillColor:(UIColor *)fillColor
                        lineJoin:(CAShapeLayerLineJoin)lineJoin;

@end

NS_ASSUME_NONNULL_END
