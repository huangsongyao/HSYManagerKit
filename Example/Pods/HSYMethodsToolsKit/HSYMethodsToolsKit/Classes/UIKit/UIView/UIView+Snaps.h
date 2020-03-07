//
//  UIView+Snaps.h
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Snaps)

/**
 把视图绘制成一张图片
 
 @return 根据视图绘制出的图片，此图片已经addSubview到一个新的视图上，返回的是该super的视图
 */
- (UIView *)hsy_snapshot;

/**
 把视图绘制成一张图片UIImageView
 
 @return 绘制好的图片
 */
- (UIImageView *)hsy_snapshotImageView;

/**
 把视图绘制成一张图片UIImage
 
 @return 绘制好的图片
 */
- (UIImage *)hsy_snapshotImage;


@end

NS_ASSUME_NONNULL_END
