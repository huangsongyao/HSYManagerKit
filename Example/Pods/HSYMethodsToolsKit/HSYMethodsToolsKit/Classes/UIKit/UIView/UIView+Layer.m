//
//  UIView+Layer.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/12/16.
//

#import "UIView+Layer.h"
#import "UIView+Frame.h"

@implementation UIView (Layer)

- (void)hsy_setRoundnessCornerRadius
{
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    BOOL widthGreaterThanHeights = (self.width > self.height);
    self.layer.cornerRadius = (widthGreaterThanHeights ? (self.height / 2.0f) : (self.width / 2.0f));
}

@end
