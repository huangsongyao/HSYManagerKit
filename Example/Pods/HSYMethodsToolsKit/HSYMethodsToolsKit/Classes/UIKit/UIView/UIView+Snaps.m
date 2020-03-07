//
//  UIView+Snaps.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/11/16.
//

#import "UIView+Snaps.h"
#import "UIView+Frame.h"

@implementation UIView (Snaps)

- (UIView *)hsy_snapshot
{
    return [UIView hsy_snapshotFromView:self];
}

+ (UIView *)hsy_snapshotFromView:(UIView *)view
{
    UIImageView *snapshotImageView = [UIView hsy_snapshotImageView:view];
    if (!view) {
        return nil;
    }
    UIView *snapshotView = [[UIView alloc] initWithFrame:snapshotImageView.frame];
    snapshotImageView.origin = CGPointZero;
    [snapshotView addSubview:snapshotImageView];
    
    return snapshotView;
}

- (UIImageView *)hsy_snapshotImageView
{
    return [UIView hsy_snapshotImageView:self];
}

- (UIImage *)hsy_snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImageView *)hsy_snapshotImageView:(UIView *)view
{
    if (!view) {
        return nil;
    }
    UIImage *image = [view hsy_snapshotImage];
    
    UIImageView *snapshotImageView = [[UIImageView alloc] initWithImage:image];
    snapshotImageView.center = view.center;
    snapshotImageView.layer.masksToBounds = NO;
    snapshotImageView.layer.cornerRadius = view.layer.cornerRadius;
    snapshotImageView.layer.shadowOffset = view.layer.shadowOffset;
    snapshotImageView.layer.shadowRadius = view.layer.shadowRadius;
    snapshotImageView.layer.shadowOpacity = view.layer.shadowOpacity;
    
    return snapshotImageView;
}


@end
