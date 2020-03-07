//
//  NSDate+Timestamp.h
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, kHSYMethodsToolsKitWeekState) {
    
    kHSYMethodsToolsKitWeekStateMonday      = 1,                                                        //星期一
    kHSYMethodsToolsKitWeekStateTuesday     = 2,                                                        //星期二
    kHSYMethodsToolsKitWeekStateWednesday   = 3,                                                        //星期三
    kHSYMethodsToolsKitWeekStateThursday    = 4,                                                        //星期四
    kHSYMethodsToolsKitWeekStateFriday      = 5,                                                        //星期五
    kHSYMethodsToolsKitWeekStateSaturday    = 6,                                                        //星期六
    kHSYMethodsToolsKitWeekStateSunday      = 7,                                                        //星期日
    
};

#define D_MINUTE            60                                                                          //一分钟等于60秒
#define D_HOUR              3600                                                                        //一小时等于3600秒
#define D_DAY               86400                                                                       //一天等于86400秒
#define D_WEEK              604800                                                                      //一星期等于604800秒
#define D_YEAR              31556926                                                                    //一年等于31556926秒

FOUNDATION_EXPORT NSString *const kHSYMethodsToolsForMonday;                                            //星期一string
FOUNDATION_EXPORT NSString *const kHSYMethodsToolsForTuesday;                                           //星期二string
FOUNDATION_EXPORT NSString *const kHSYMethodsToolsForWednesday;                                         //星期三string
FOUNDATION_EXPORT NSString *const kHSYMethodsToolsForThursday;                                          //星期四string
FOUNDATION_EXPORT NSString *const kHSYMethodsToolsForFriday;                                            //星期五string
FOUNDATION_EXPORT NSString *const kHSYMethodsToolsForSaturday;                                          //星期六string
FOUNDATION_EXPORT NSString *const kHSYMethodsToolsForSunday;                                            //星期日string

typedef NSString *kHSYMethodsToolsKitDateFormater;
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_yyyyMMddHHmmss;                    //yyyy-MM-dd HH:mm:ss
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_MMddHHmm;                          //MM/dd HH:mm
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_yyyyMMdd;                          //yyyy年MM月dd日
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_yyyy_MM_dd;                        //yyyy-MM-dd
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_MMdd;                              //MM月dd日
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_MM_dd;                             //MM-dd
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_HHmmss;                            //HH:mm:ss
FOUNDATION_EXPORT kHSYMethodsToolsKitDateFormater const DateFormater_HHmm;                              //HH:mm

@interface NSDate (Timestamp)

/**
 返回一个日期格式器NSDateFormatter单例
 
 @param string 日期格式，例如宏D_yyyyMMddHHmmss的字符串
 @return 日期格式器
 */
+ (NSDateFormatter *)hsy_formatterWithString:(kHSYMethodsToolsKitDateFormater)string;

#pragma mark - System Date

/**
 返回由[NSDate date]通过设备所在地时区转换的真实的当前时间，即：[NSDate date]+格林尼治时间差 => [NSDate hsy_realDate]

 @return 设备所在地时区转换的真实的当前时间
 */
+ (NSDate *)hsy_realDate;

/**
 通过[NSDate hsy_realDate]返回11位的时间戳

 @return 11位的时间戳
 */
+ (NSTimeInterval)hsy_timestampMilliseconds;

/**
 + (NSTimeInterval)hsy_timestampMilliseconds方法的时间戳转换为字符串

 @return 11位的时间戳
 */
+ (NSString *)hsy_timestampMillisecondStrings;

#pragma mark - Timestamp To NSDate

/**
 时间戳转时间，并且方法中已经对时间戳timestamp定义了，如果超过11位，则默认为需要将timestamp这个时间戳除以1000

 @param timestamp 时间戳
 @return 时间戳对应的时间格式
 */
+ (NSDate *)hsy_toDate:(NSTimeInterval)timestamp;

/**
 时间戳转时间字符串，并且方法中已经对时间戳timestamp定义了，如果超过11位，则默认为需要将timestamp这个时间戳除以1000

 @param timestamp 时间戳
 @param dataFormatter kHSYMethodsToolsKitDateFormater类型，为时间格式化的字符串
 @return 时间戳对应的时间格式的时间字符串
 */
+ (NSString *)hsy_toDateString:(NSTimeInterval)timestamp dataFormatterString:(kHSYMethodsToolsKitDateFormater)dataFormatter;

#pragma mark - Next Date && Last Date

/**
 当前时间的间隔24小时后，如：当前时间为2019-09-26 16:52:46 +0000，则方法返回值为：2019-09-27 16:52:46 +0000

 @return 明天的这个时间
 */
- (NSDate *)hsy_tomorrow;

/**
 当前时间的间隔24小时前，如：当前时间为2019-09-26 16:52:46 +0000，则方法返回值为：2019-09-25 16:52:46 +0000

 @return 昨天的这个时间
 */
- (NSDate *)hsy_yesterday;

/**
 当前时间的间隔一个月后，如：当前时间为2019-09-26 16:52:46 +0000，则方法返回值为：2019-10-26 16:52:46 +0000

 @return 下个月的这个时间
 */
- (NSDate *)hsy_nextMonths;

/**
 当前时间的间隔一个月前，如：当前时间为2019-09-26 16:52:46 +0000，则方法返回值为：2019-08-27 16:52:46 +0000

 @return 上个月的这个时间
 */
- (NSDate *)hsy_lastMonths;

#pragma mark - NSDate To NSString

- (NSString *)hsy_stringyyyyMMddHHmmss;
- (NSString *)hsy_stringMMddHHmm;
- (NSString *)hsy_stringyyyyMMdd;
- (NSString *)hsy_stringyyyy_MM_dd;
- (NSString *)hsy_stringMMdd;
- (NSString *)hsy_stringMM_dd;
- (NSString *)hsy_stringHHmmss;
- (NSString *)hsy_stringHHmm;

#pragma mark - NSDate To Weeks

/**
 设备所在时区的当前日期对应的星期

 @return 当前日期对应的星期
 */
+ (NSString *)hsy_dateToWeek;

/**
 设备所在时区的当前日期对应的星期的类型枚举

 @return 当前日期对应的星期的类型枚举
 */
+ (kHSYMethodsToolsKitWeekState)hsy_weekdayEnum;

#pragma mark - Equal Date

/**
 判断两个日期是否为相同

 @param date 另一个日期
 @return 相同返回YES，否则返回NO
 */
- (BOOL)hsy_isEqualDate:(NSDate *)date;

/**
 判断两个日期是否是同年同月同日

 @param date 另一个日期
 @return 同年同月同日返回YES，否则返回NO
 */
- (BOOL)hsy_isEqualDay:(NSDate *)date;

/**
 判断两个日期是否是同年同月

 @param date 另一个日期
 @return 是同年同月返回YES，否则返回NO
 */
- (BOOL)hsy_isEqualMonth:(NSDate *)date;

/**
 判断两个日期是否是同年

 @param date 另一个日期
 @return 是同年返回YES，否则返回NO
 */
- (BOOL)hsy_isEqualYear:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
