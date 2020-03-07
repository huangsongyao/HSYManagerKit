//
//  UIBezierPath+Shape.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import "UIBezierPath+Shape.h"

@implementation UIBezierPath (Shape)

+ (CAShapeLayer *)hsy_BezierPath:(NSArray<NSValue *> *)beziers lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineJoin:(CAShapeLayerLineJoin)lineJoin
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGPoint firstCGPoint = beziers.firstObject.CGPointValue;
    [bezierPath moveToPoint:firstCGPoint];
    for (NSInteger i = 1; i < beziers.count; i ++) {
        CGPoint otherCGPoint = beziers[i].CGPointValue;
        [bezierPath addLineToPoint:otherCGPoint];
    }
    [bezierPath closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = lineWidth;
    layer.strokeColor = strokeColor.CGColor;
    layer.fillColor = fillColor.CGColor;
    layer.lineJoin = lineJoin;
    
    layer.path = bezierPath.CGPath;
    return layer;
}


@end
