//
//  UINavigationBar+NavigationItem.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import "UINavigationBar+NavigationItem.h"
#import "UIButton+UIKit.h"
#import "UIView+Frame.h"
#import "UILabel+SuggestSize.h"
#import "NSString+StringSize.h"
#import "NSBundle+PrivateFileResource.h"
#import <HSYMacroKit/HSYToolsMacro.h>

@implementation UINavigationBar (NavigationItem)

+ (NSArray<UIBarButtonItem *> *)hsy_imageNavigationItems:(NSArray<NSDictionary<NSNumber *, NSDictionary *> *> *)paramters leftEdgeInsets:(CGFloat)left subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    NSMutableArray<UIBarButtonItem *> *barButtonItems = [NSMutableArray arrayWithCapacity:paramters.count];
    for (NSDictionary *paramter in paramters) {
        UIImage *image = [NSBundle hsy_imageForBundle:[paramter.allValues.firstObject allKeys].firstObject];
        UIImage *hightlightImage = [NSBundle hsy_imageForBundle:[paramter.allValues.firstObject allObjects].firstObject];
        UIButton *barButton = [self.class hsy_buttonWithEdgeInsets:left forButtonTag:[paramter.allKeys.firstObject integerValue] clickedOnAction:^(UIButton *button) {
            if (next) {
                next(button, button.tag);
            }
        }];
        [barButton setImage:image forState:UIControlStateNormal];
        [barButton setImage:hightlightImage forState:UIControlStateHighlighted];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
        [barButtonItems addObject:barButtonItem];
    }
    return barButtonItems;
}

+ (NSArray<UIBarButtonItem *> *)hsy_titleNavigationItems:(NSArray<NSDictionary<NSDictionary<NSNumber *, UIFont *> *, NSDictionary<NSString *, UIColor *> *> *> *)paramters leftEdgeInsets:(CGFloat)left subscribeNext:(void(^)(UIButton *button, NSInteger tag))next
{
    NSMutableArray<UIBarButtonItem *> *barButtonItems = [NSMutableArray arrayWithCapacity:paramters.count];
    for (NSDictionary *paramter in paramters) {
        NSString *title = [paramter.allValues.firstObject allKeys].firstObject;
        UIColor *titleColor = [paramter.allValues.firstObject allObjects].firstObject;
        NSNumber *tagNumber = [paramter.allKeys.firstObject allKeys].firstObject;
        UIFont *font = [paramter.allKeys.firstObject allObjects].firstObject;
        UIButton *barButton = [self.class hsy_buttonWithEdgeInsets:left forButtonTag:tagNumber.integerValue clickedOnAction:^(UIButton *button) {
            if (next) {
                next(button, button.tag);
            }
        }];
        barButton.titleLabel.font = font;
        [barButton hsy_setTitle:title];
        [barButton hsy_setTitleColor:titleColor];
        barButton.width = MIN((([barButton.titleLabel.text hsy_boundingRectWithHeights:barButton.titleLabel.font.lineHeight font:barButton.titleLabel.font].width + left/2.0f)), IPHONE_WIDTH);
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
        [barButtonItems addObject:barButtonItem];
    }
    return barButtonItems;
}

+ (UIButton *)hsy_buttonWithEdgeInsets:(CGFloat)left forButtonTag:(NSInteger)tag clickedOnAction:(void (^)(UIButton *button))action
{
    UIButton *barButton = [UIButton hsy_buttonWithAction:action];
    barButton.size = CGSizeMake(kHSYCustomNavigationBarButtonForSize, kHSYCustomNavigationBarButtonForSize); 
    barButton.contentEdgeInsets = UIEdgeInsetsMake(0.0f, left, 0.0f, 0.0f);
    barButton.tag = tag;
    
    return barButton;
}

@end
