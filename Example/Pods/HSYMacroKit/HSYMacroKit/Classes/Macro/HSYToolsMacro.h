//
//  HSYToolsMacro.h
//  HSYMacroKit
//
//  Created by anmin on 2019/9/27.
//

#ifndef HSYToolsMacro_h
#define HSYToolsMacro_h

//debug模式下的NSLog
#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)

#else

#define NSLog(...)
#define debugMethod()

#endif


//简化CGPoint、CGSize、CGRect的NSLog
#define NSLogPoint(point)           NSLog(@"{\n x=%f, y=%f}", point.x, point.y)
#define NSLogSize(size)             NSLog(@"{\n width=%f, height=%f}", size.width, size.height)
#define NSLogRect(rect)             NSLog(@"{\n x=%f, y=%f, width=%f, height=%f}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)


//国际化使用的文字赋值
#define HSYLOCALIZED(ver)                                               NSLocalizedString(ver, nil)


//屏幕尺寸
#define IPHONE_WIDTH                                                    ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_HEIGHT                                                   ([UIScreen mainScreen].bounds.size.height)
#define IPHONE_SCALE                                                    ([UIScreen mainScreen].scale)
#define IPHONE_HEIGHT_RESOLUTION_RATIO                                  (IPHONE_HEIGHT * IPHONE_SCALE)
#define IPHONE_WIDTH_RESOLUTION_RATIO                                   (IPHONE_WIDTH * IPHONE_SCALE)



//以4.7寸iPhone6、iPhone6s为模板，动态计算其他屏幕的宽高
#define WIDTHS_OF_SCALE(x)                                              ((x) * (IPHONE_WIDTH / 375.0))
#define HEIGHTS_OF_SCALE(x)                                             ((x) * (IPHONE_HEIGHT / 667.0))



//设备系统
#define IPHONE_SYSTEM_VERSION                                           [[[UIDevice currentDevice] systemVersion] floatValue]



//刘海屏
#define HSY_IS_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})


//获取RGB颜色
#define HSY_RGBA(r, g, b, a)             [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HSY_RGB(r, g, b)                 HSY_RGBA(r, g, b, 1.0f)
#define HSY_RANDOM_RGBA(alpha)           HSY_RGBA((arc4random()%256), (arc4random()%256), (arc4random()%256), alpha)
#define HSY_RANDOM_RGB                   HSY_RANDOM_RGBA(1.0f)
#define HSY_HEX_COLOR(c)                 [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]
#define HSY_HEX_COLORA(c, a)             [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:a]
#define HSY_HEX_COLOR_STRING(rgbValue)   [UIColor colorWithRed:((float)((strtoul(((NSString *)rgbValue).UTF8String, 0, 16) & 0xFF0000) >> 16))/255.0 green:((float)((strtoul(((NSString *)rgbValue).UTF8String, 0, 16) & 0xFF00) >> 8))/255.0 blue:((float)(strtoul(((NSString *)rgbValue).UTF8String, 0, 16) & 0xFF))/255.0 alpha:1.0]



//系统文字的font
#define HSY_SYSTEM_FONT_SIZE(ver)                                       [UIFont systemFontOfSize:ver]
//系统文字的font 加粗
#define HSY_SYSTEM_BOLD_FONT_SIZE(ver)                                  [UIFont boldSystemFontOfSize:ver]
//系统默认字号适配宏，wordSize表示通用字号，fitSize表示适配字号，最终字号为(wordSize-fitSize)
#define HSY_SYSTEM_FONT_FIT_SIZE(wordSize, fitSize)                     HSY_SYSTEM_FONT_SIZE((wordSize-fitSize))
#define HSY_SYSTEM_BOLD_FONT_FIT_SIZE(wordSize, fitSize)                HSY_SYSTEM_BOLD_FONT_SIZE((wordSize-fitSize))



//忽略执行警告
#define HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



//角度转弧度
#define DEGREES_TO_RADIANS(angle)                                       (angle * M_PI / 180.0f)
//弧度转角度
#define RADIANS_TO_DEGREES(radian)                                      ((radian * 180.0f) / M_PI)



//设备类型，真机或者模拟器
#ifndef TARGET_DEVICE_IS_OS_IPHONE
#if TARGET_IPHONE_SIMULATOR
#define TARGET_DEVICE_IS_OS_IPHONE  NO
#elif TARGET_OS_IPHONE
#define TARGET_DEVICE_IS_OS_IPHONE  YES
#endif
#endif



//CGAffineTransformIdentity格式的放缩
#define HSYCOCOAKIT_GGA_TRANSFORM_SCALES(scale1, scale2)                (CGAffineTransformScale(CGAffineTransformIdentity, scale1, scale2))
#define HSYCOCOAKIT_GGA_TRANSFORM_SCALE(scale)                          HSYCOCOAKIT_GGA_TRANSFORM_SCALES(scale, scale)
//绕圆心的旋转动画
#define HSYCOCOAKIT_GGA_ROTATION(angle)                                 (CGAffineTransformMakeRotation(angle))



//方法可用限制
#define HSY_NS_AVAILABLE_IOS(versions)                  NS_AVAILABLE_IOS(versions)
#define HSY_AVAILABLE_IOS_8                             HSY_NS_AVAILABLE_IOS(8_0)
#define HSY_AVAILABLE_IOS_9                             HSY_NS_AVAILABLE_IOS(9_0)
#define HSY_AVAILABLE_IOS_10                            HSY_NS_AVAILABLE_IOS(10_0)
#define HSY_AVAILABLE_IOS_11                            HSY_NS_AVAILABLE_IOS(11_0)
#define HSY_AVAILABLE_IOS_12                            HSY_NS_AVAILABLE_IOS(12_0)
#define HSY_AVAILABLE_IOS_13                            HSY_NS_AVAILABLE_IOS(13_0)




#endif /* HSYToolsMacro_h */
