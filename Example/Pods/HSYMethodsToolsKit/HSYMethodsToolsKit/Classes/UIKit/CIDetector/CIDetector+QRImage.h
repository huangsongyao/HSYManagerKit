//
//  CIDetector+QRImage.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/15.
//

#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIDetector (QRImage)

/**
 识别图片中的二维码，相机拍照获取的二维码不能非常准备的识别到
 
 @param image 图片
 @return 识别结果
 */
+ (NSString *)hsy_detectorQRImage:(UIImage *)image NS_AVAILABLE_IOS(8_0);

/**
 根据给定的字符串生成”高容错“率的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @return 二维码图片
 */
+ (UIImage *)hsy_highQRImage:(NSString *)qrString
               withImageSize:(CGFloat)size NS_AVAILABLE_IOS(8_0);

/**
 根据给定的字符串生成“中容错”率的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @return 二维码图片
 */
+ (UIImage *)hsy_middleQRImage:(NSString *)qrString
                 withImageSize:(CGFloat)size NS_AVAILABLE_IOS(8_0);

/**
 根据给定的字符串生成“低容错”率的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @return 二维码图片
 */
+ (UIImage *)hsy_lowQRImage:(NSString *)qrString
              withImageSize:(CGFloat)size NS_AVAILABLE_IOS(8_0);

/**
 根据给定的字符串生成”高容错“率的中间带logo的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @param logo logo图片的名称
 @param logoSize logo图片
 @return 中间带logo的”高容错“率二维码图片
 */
+ (UIImage *)hsy_highLogoQRImage:(NSString *)qrString
                   withImageSize:(CGFloat)size
                            logo:(UIImage *)logo
                        logoSize:(CGFloat)logoSize NS_AVAILABLE_IOS(8_0);

/**
 根据给定的字符串生成”中容错“率的中间带logo的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @param logo logo图片的名称
 @param logoSize logo图片
 @return 中间带logo的”中容错“率二维码图片
 */
+ (UIImage *)hsy_middleLogoQRImage:(NSString *)qrString
                     withImageSize:(CGFloat)size
                              logo:(UIImage *)logo
                          logoSize:(CGFloat)logoSize NS_AVAILABLE_IOS(8_0);

/**
 根据给定的字符串生成”低容错“率的中间带logo的二维码图片
 
 @param qrString 给定的字符串
 @param size 二维码图片的size
 @param logo logo图片
 @param logoSize logo图片的size
 @return 中间带logo的”低容错“率二维码图片
 */
+ (UIImage *)hsy_lowLogoQRImage:(NSString *)qrString
                  withImageSize:(CGFloat)size
                           logo:(UIImage *)logo
                       logoSize:(CGFloat)logoSize NS_AVAILABLE_IOS(8_0);


@end

NS_ASSUME_NONNULL_END
