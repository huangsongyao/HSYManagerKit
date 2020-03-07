//
//  CIDetector+QRImage.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/15.
//

#import "CIDetector+QRImage.h"
#import "UIImage+Compression.h"
#import "UIImage+Canvas.h"

NSString *const kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsHigh        = @"H";
NSString *const kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsMiddle      = @"M";
NSString *const kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsLow         = @"L";

#define DEFAULT_DETECTOR_IMAGE_REAL_SIZE                CGSizeMake(280.0f, 280.0f)

@implementation CIDetector (QRImage)

#pragma mark - Identify QRImage

+ (NSString *)hsy_detectorQRImage:(UIImage *)image
{
    CIContext *ciContent = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES), }];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContent options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    
    UIImage *realImage = image;
    if (!CGSizeEqualToSize(realImage.size, DEFAULT_DETECTOR_IMAGE_REAL_SIZE)) {
        realImage = [realImage hsy_imageCompressionSize:DEFAULT_DETECTOR_IMAGE_REAL_SIZE];
    }
    
    CIImage *ciImage = [CIImage imageWithCGImage:realImage.CGImage];
    NSArray<CIFeature *> *features = [detector featuresInImage:ciImage];
    if (!features.count) {
        return @"not features!";
    }
    CIQRCodeFeature *feature = (CIQRCodeFeature *)features.firstObject;
    NSString *result = feature.messageString;
    
    NSLog(@"\n detector QRCode is : %@", result);
    return result;
}

#pragma mark - QRCode Image

+ (UIImage *)hsy_qrCodeImage:(NSString *)qrString
           qrCorrectionLevel:(NSString *)level
               withImageSize:(CGFloat)size
{
    if (qrString.length == 0) {
        return nil;
    }
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:level forKey:@"inputCorrectionLevel"];
    
    CIImage *ciImage = [filter outputImage];
    UIImage *qrCodeImage = [UIImage hsy_imageWithQRCodeSize:size withCIImage:ciImage];
    
    return qrCodeImage;
}

+ (UIImage *)hsy_highQRImage:(NSString *)qrString withImageSize:(CGFloat)size
{
    return [self.class hsy_qrCodeImage:qrString
                     qrCorrectionLevel:kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsHigh
                         withImageSize:size];
}

+ (UIImage *)hsy_middleQRImage:(NSString *)qrString withImageSize:(CGFloat)size
{
    return [self.class hsy_qrCodeImage:qrString
                     qrCorrectionLevel:kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsMiddle
                         withImageSize:size];
}

+ (UIImage *)hsy_lowQRImage:(NSString *)qrString withImageSize:(CGFloat)size
{
    return [self.class hsy_qrCodeImage:qrString
                     qrCorrectionLevel:kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsLow
                         withImageSize:size];
}

#pragma mark - Logo QRCode Image

+ (UIImage *)hsy_logoQrCodeImage:(NSString *)qrString
               qrCorrectionLevel:(NSString *)level
                   withImageSize:(CGFloat)size
                            logo:(UIImage *)logo
                        logoSize:(CGFloat)logoSize
{
    UIImage *qrCodeImage = [CIDetector hsy_qrCodeImage:qrString
                                     qrCorrectionLevel:level
                                         withImageSize:size];
    if (!logo) {
        return qrCodeImage;
    }
    UIGraphicsBeginImageContext(qrCodeImage.size);
    [qrCodeImage drawInRect:(CGRect){CGPointZero, qrCodeImage.size}];
    CGRect logoRect = (CGRect){(qrCodeImage.size.width - logoSize)/2.0f, (qrCodeImage.size.height - logoSize)/2.0f, CGSizeMake(logoSize, logoSize)};
    [logo drawInRect:logoRect];
    
    UIImage *logoQrCodeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return logoQrCodeImage;
}

+ (UIImage *)hsy_highLogoQRImage:(NSString *)qrString
                   withImageSize:(CGFloat)size
                            logo:(UIImage *)logo
                        logoSize:(CGFloat)logoSize
{
    return [self.class hsy_logoQrCodeImage:qrString
                         qrCorrectionLevel:kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsHigh
                             withImageSize:size
                                      logo:logo
                                  logoSize:logoSize];
}

+ (UIImage *)hsy_middleLogoQRImage:(NSString *)qrString
                     withImageSize:(CGFloat)size
                              logo:(UIImage *)logo
                          logoSize:(CGFloat)logoSize
{
    return [self.class hsy_logoQrCodeImage:qrString
                         qrCorrectionLevel:kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsMiddle
                             withImageSize:size
                                      logo:logo
                                  logoSize:logoSize];
}

+ (UIImage *)hsy_lowLogoQRImage:(NSString *)qrString
                  withImageSize:(CGFloat)size
                           logo:(UIImage *)logo
                       logoSize:(CGFloat)logoSize
{
    return [self.class hsy_logoQrCodeImage:qrString
                         qrCorrectionLevel:kHSYMethodsToolsKitCIFilterInputCorrectionLevelIsLow
                             withImageSize:size
                                      logo:logo
                                  logoSize:logoSize];
}

@end
