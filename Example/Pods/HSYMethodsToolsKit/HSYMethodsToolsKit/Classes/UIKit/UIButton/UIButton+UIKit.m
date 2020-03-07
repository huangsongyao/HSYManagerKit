//
//  UIButton+UIKit.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/15.
//

#import "UIButton+UIKit.h"
#import "ReactiveObjC.h"
#import "NSString+StringSize.h"
#import "UIView+Frame.h"
#import "RACSignal+Convenients.h"

@implementation UIButton (UIKit)

+ (instancetype)hsy_buttonWithAction:(void(^)(UIButton *button))action
{
    return [UIButton hsy_buttonWithEnabledAction:^RACSignal *(UIButton *button) {
        if (action) {
            action(button);
        }
        return [RACSignal hsy_sendCompletedSignal];
    }];
}

+ (instancetype)hsy_buttonWithEnabledAction:(RACSignal *(^)(UIButton *button))action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [[[button rac_signalForControlEvents:UIControlEventTouchUpInside] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (action) {
            x.userInteractionEnabled = NO;
            [[action((UIButton *)x) deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{
                x.userInteractionEnabled = YES;
            }];
        }
    }];
    return button;
}

#pragma mark - Methods

- (void)hsy_setTitle:(NSString *)title
{
    if (title.length) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateHighlighted];
    }
}

- (void)hsy_setTitleColor:(UIColor *)color
{
    if (color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateHighlighted];
    }
}

- (void)hsy_setTitleShadowColor:(UIColor *)color
{
    if (color) {
        [self setTitleShadowColor:color forState:UIControlStateNormal];
        [self setTitleShadowColor:color forState:UIControlStateHighlighted];
    }
}

- (void)hsy_setImage:(UIImage *)image
{
    if (image) {
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
    }
}

- (void)hsy_setBackgroundImage:(UIImage *)image
{
    if (image) {
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
    }
}

- (void)hsy_setAttributedTitle:(NSAttributedString *)title
{
    if (title.string.length) {
        [self setAttributedTitle:title forState:UIControlStateNormal];
        [self setAttributedTitle:title forState:UIControlStateHighlighted];
    }
}

- (void)hsy_setImagePosition:(kHSYMethodsToolsButtonImagePosition)position forSpacing:(CGFloat)spacing
{
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    CGSize size = [self.currentTitle hsy_boundingRectWithWidths:self.width font:self.titleLabel.font];
    CGFloat labelWidth = size.width;
    CGFloat labelHeight = size.height;
    
    CGFloat divisors = 2.0f;
    CGFloat imageOffsetX = (imageWidth + labelWidth) / divisors - imageWidth / divisors;
    CGFloat imageOffsetY = imageHeight / divisors + spacing / divisors;
    CGFloat labelOffsetX = (imageWidth + labelWidth / divisors) - (imageWidth + labelWidth) / divisors;
    CGFloat labelOffsetY = labelHeight / divisors + spacing / divisors;
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets contentEdgeInsets = UIEdgeInsetsZero;
    
    switch (position) {
        case kHSYMethodsToolsButtonImagePositionLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case kHSYMethodsToolsButtonImagePositionRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case kHSYMethodsToolsButtonImagePositionTop:
            imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case kHSYMethodsToolsButtonImagePositionBottom:
            imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
        default:
            break;
    }
    
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
    self.contentEdgeInsets = contentEdgeInsets;
    
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        NSArray *positions = @[@(kHSYMethodsToolsButtonImagePositionLeft), @(kHSYMethodsToolsButtonImagePositionRight)];
        CGFloat widths = ([positions containsObject:@(position)] ? ceil((imageWidth + labelWidth + spacing)) : MAX(imageWidth, labelWidth));
        CGFloat heights = ([positions containsObject:@(position)] ? MAX(imageHeight, labelHeight) : ceil((imageHeight + labelHeight + spacing)));
        self.size = CGSizeMake(widths, heights);
    }
}

@end
