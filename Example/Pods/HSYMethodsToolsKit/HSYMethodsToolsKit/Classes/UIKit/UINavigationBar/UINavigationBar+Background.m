//
//  UINavigationBar+Background.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "UINavigationBar+Background.h"
#import "UIImage+Canvas.h"
#import "Masonry.h" 

static NSInteger const kXQCCustomNavigationBarBottomlineColorForKeys        = 2018;

@implementation UINavigationBar (Background)

- (void)hsy_setNavigationBarBackgroundImage:(UIImage *)backgroundImage
{
    UIImage *image = backgroundImage;
    if (!image) {
        image = [UIImage hsy_imageWithFillColor:UIColor.whiteColor];
    }
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)hsy_setNavigationBarBottomlineColor:(UIColor *)color
{
    [self setShadowImage:[UIImage hsy_imageWithFillColor:UIColor.clearColor]];
    UIView *line = [self viewWithTag:kXQCCustomNavigationBarBottomlineColorForKeys];
    if (!line) {
        line = [[UIView alloc] init];
        line.tag = kXQCCustomNavigationBarBottomlineColorForKeys;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@(0.5f));
        }];
    }
    line.backgroundColor = color;
}

- (void)hsy_clearNavigationBarBottomline
{
    [self hsy_setNavigationBarBottomlineColor:UIColor.clearColor];
}

@end
