//
//  UIButton+Loading.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/12/13.
//

#import "UIButton+Loading.h"
#import "NSObject+Property.h" 
#import "UIView+Frame.h"
#import <ReactiveObjC/ReactiveObjC.h>

static NSString *kHSYMethodsToolsButtonLoadingForKey    = @"HSYMethodsToolsButtonLoadingForKey";
static NSInteger const kHSYMethodsToolsButtonLoadingForMaskTags = 1993;

@interface UIButton (Private)

- (UIActivityIndicatorView *)hsy_containsLoading;
- (UIView *)hsy_maskView;

@end

@implementation UIButton (Private)

- (UIActivityIndicatorView *)hsy_containsLoading
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            return (UIActivityIndicatorView *)view;
        }
    }
    return nil;
}

- (UIView *)hsy_maskView
{
    NSInteger forTags = kHSYMethodsToolsButtonLoadingForMaskTags;
    for (UIView *view in self.subviews) {
        if (view.tag == forTags) {
            return view;
        }
    }
    return nil;
}

@end

@implementation UIButton (Loading)
 
- (void)hsy_loadingButton:(UIColor *)maskColor forMap:(RACSignal *(^)(BOOL isAnimating))map
{
    [self hsy_loadingButton:maskColor forMap:map resetStateFinished:^(UIButton *button) {}];
}

- (void)hsy_loadingButton:(UIColor *)maskColor forMap:(RACSignal *(^)(BOOL isAnimating))map resetStateFinished:(void(^)(UIButton *button))reset
{
    //点击后，首先先禁用按钮的交互状态
    self.userInteractionEnabled = NO;
    //隔层视图
    UIView *hsy_maskView = self.hsy_maskView;
    if (!hsy_maskView) {
        hsy_maskView = [[UIView alloc] init];
        hsy_maskView.backgroundColor = maskColor;
        hsy_maskView.hidden = YES;
        [self addSubview:hsy_maskView];
    }
    //loading视图
    UIActivityIndicatorView *hsy_loadingView = self.hsy_containsLoading;
    if (!hsy_loadingView) {
        hsy_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:hsy_loadingView];
    }
    //loading视图放置在按钮的最外层
    [self bringSubviewToFront:hsy_loadingView];
    //根据按钮的原始size来决定是采用width>height的模式还是height>width的模式
    BOOL widthGreaterThanHeights = (self.width > self.height);
    CGSize loadingCGSize = (widthGreaterThanHeights ? CGSizeMake(self.height, self.height) : CGSizeMake(self.width, self.width));
    //记录按钮原始的frame数据
    CGRect origin = self.frame;
    //计算好动画过程的frame的变化结果
    CGFloat x = (widthGreaterThanHeights ? (self.x + (self.width/2.0f - loadingCGSize.width/2.0f)) : self.x);
    CGFloat y = (widthGreaterThanHeights ? self.y : (self.y + (self.height/2.0f - loadingCGSize.height/2.0f))); 
    CGSize realCGSize = CGSizeMake((widthGreaterThanHeights ? loadingCGSize.width : self.width), (widthGreaterThanHeights ? self.height : loadingCGSize.height));
    CGRect rect = (CGRect){x, y, realCGSize};
    //隔层视图的size采用变化后的按钮的size
    hsy_maskView.size = realCGSize;
    @weakify(self);
    [UIView animateWithDuration:0.35f animations:^{
        @strongify(self);
        self.frame = rect;
        if (self.layer.cornerRadius > 0.0f) {
            self.layer.cornerRadius = (self.height / 2.0f);
        }
    } completion:^(BOOL finished) {
        @strongify(self);
        hsy_maskView.hidden = NO;
        hsy_loadingView.origin = CGPointMake(((self.width - hsy_loadingView.width) / 2.0f), (self.height - hsy_loadingView.height) / 2.0f);
        if (!hsy_loadingView.isAnimating) {
            [hsy_loadingView startAnimating];
        }
    }];
    if (map) {
        //由外部的高阶函数返回一个RACSignal，来决定什么时候还原按钮的原始状态
        [[map(hsy_loadingView.isAnimating) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self);
            if ([x.first boolValue]) {
                //恢复隔层视图和loading视图的初始状态
                hsy_maskView.hidden = YES;
                if (hsy_loadingView.isAnimating) {
                    [hsy_loadingView stopAnimating];
                }
                //恢复按钮的原始frame状态
                self.frame = origin;
                //恢复按钮的交互事件
                self.userInteractionEnabled = YES;
                if (reset) {
                    reset(self);
                }
            }
        }];
    }
}

@end
