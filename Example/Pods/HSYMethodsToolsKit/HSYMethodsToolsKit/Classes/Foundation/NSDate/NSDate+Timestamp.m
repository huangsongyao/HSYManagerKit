//
//  NSDate+Timestamp.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSDate+Timestamp.h"
#import "HSYToolsMacro.h"

NSString *const kHSYMethodsToolsForMonday                               = @"星期一";
NSString *const kHSYMethodsToolsForTuesday                              = @"星期二";
NSString *const kHSYMethodsToolsForWednesday                            = @"星期三";
NSString *const kHSYMethodsToolsForThursday                             = @"星期四";
NSString *const kHSYMethodsToolsForFriday                               = @"星期五";
NSString *const kHSYMethodsToolsForSaturday                             = @"星期六";
NSString *const kHSYMethodsToolsForSunday                               = @"星期天";

kHSYMethodsToolsKitDateFormater const DateFormater_yyyyMMddHHmmss       = @"yyyy-MM-dd HH:mm:ss";
kHSYMethodsToolsKitDateFormater const DateFormater_MMddHHmm             = @"MM/dd HH:mm";
kHSYMethodsToolsKitDateFormater const DateFormater_yyyyMMdd             = @"yyyy年MM月dd日";
kHSYMethodsToolsKitDateFormater const DateFormater_yyyy_MM_dd           = @"yyyy-MM-dd";
kHSYMethodsToolsKitDateFormater const DateFormater_MMdd                 = @"MM月dd日";
kHSYMethodsToolsKitDateFormater const DateFormater_MM_dd                = @"MM-dd";
kHSYMethodsToolsKitDateFormater const DateFormater_HHmmss               = @"HH:mm:ss";
kHSYMethodsToolsKitDateFormater const DateFormater_HHmm                 = @"HH:mm";

@implementation NSDate (Timestamp)

+ (NSDateFormatter *)hsy_formatterWithString:(kHSYMethodsToolsKitDateFormater)string
{
    static NSDateFormatter *shareFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareFormatter = [NSDateFormatter new];
    });
    //NSDateFormatter会自动把时间转为北京/上海标准时间，不需要额外转换
    shareFormatter.dateFormat = string;
    return shareFormatter;
}

#pragma mark - System Date

+ (NSDate *)hsy_realDate
{
    NSDate *date = [NSDate date];
    NSTimeInterval intervals = date.systemZoneIntervals;
    //通过设备所在时区和格林尼治时间的时间差，来生成一个真实的设备所在地的当前时间
    NSDate *realDate = [date dateByAddingTimeInterval:intervals];
    return realDate;
}

+ (NSTimeInterval)hsy_timestampMilliseconds
{
    NSDate *date = self.class.hsy_realDate;
    return [date timeIntervalSince1970];
}

+ (NSString *)hsy_timestampMillisecondStrings
{
    return [NSString stringWithFormat:@"%@", @(self.class.hsy_timestampMilliseconds)];
}

- (NSTimeInterval)systemZoneIntervals
{
    //通过[NSDate date]和设备所在地时区，来返回一个跟格林尼治时间相差的时间差
    NSTimeZone *systemZone = [NSTimeZone systemTimeZone];
    NSTimeInterval intervals = [systemZone secondsFromGMTForDate:self];
    return intervals;
}

#pragma mark - Timestamp To NSDate

+ (NSDate *)hsy_toDate:(NSTimeInterval)timestamp
{
    NSTimeInterval realTimestamp = timestamp;
    //时间戳为11位的，如果超过11位表示默认为除以1000获取11位的时间戳
    if ([NSString stringWithFormat:@"%@", @(realTimestamp)].length > 11) {
        realTimestamp = realTimestamp/1000;
    }
    return [NSDate dateWithTimeIntervalSince1970:realTimestamp];
}

+ (NSString *)hsy_toDateString:(NSTimeInterval)timestamp dataFormatterString:(kHSYMethodsToolsKitDateFormater)dataFormatter
{
    NSDate *date = [NSDate hsy_toDate:timestamp];
    NSString *dateString = [[NSDate hsy_formatterWithString:dataFormatter] stringFromDate:date];
    return dateString;
}

#pragma mark - Next Date && Last Date

- (NSDate *)hsy_tomorrow
{
    return [self hsy_thisDays:YES];
}

- (NSDate *)hsy_yesterday
{
    return [self hsy_thisDays:NO];
}

- (NSDate *)hsy_thisDays:(BOOL)isNext
{
    NSTimeInterval intervals = D_DAY;
    if (!isNext) {
        intervals = -intervals;
    }
    NSDate *days = [NSDate dateWithTimeInterval:intervals sinceDate:self];
    return days;
}

- (NSDate *)hsy_nextMonths
{
    return [self hsy_thisMonths:YES];
}

- (NSDate *)hsy_lastMonths
{
    return [self hsy_thisMonths:NO];
}

- (NSDate *)hsy_thisMonths:(BOOL)isNext
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = (NSCalendarUnitYear |
                        NSCalendarUnitMonth);
    NSDateComponents *dateComponent = [calendar components:flags fromDate:self];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    
    NSInteger endDate = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            endDate = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            endDate = 30;
            break;
        case 2:
            if (year % 400 == 0) {
                endDate = 29;
            } else {
                if ((year % 100 != 0) && (year % 4 == 4)) {
                    endDate = 29;
                } else {
                    endDate = 28;
                }
            }
            break;
        default:
            break;
    }
    
    NSTimeInterval intervals = (D_DAY * endDate);
    if (!isNext) {
        intervals = -intervals;
    }
    NSDate *nextMonthDate = [NSDate dateWithTimeInterval:intervals sinceDate:self];
    return nextMonthDate;
}

#pragma mark - NSDate To NSString

- (NSString *)hsy_stringyyyyMMddHHmmss
{
    return [[NSDate hsy_formatterWithString:DateFormater_yyyyMMddHHmmss] stringFromDate:self];
}

- (NSString *)hsy_stringMMddHHmm
{
    return [[NSDate hsy_formatterWithString:DateFormater_MMddHHmm] stringFromDate:self];
}

- (NSString *)hsy_stringyyyyMMdd
{
    return [[NSDate hsy_formatterWithString:DateFormater_yyyyMMdd] stringFromDate:self];
}

- (NSString *)hsy_stringyyyy_MM_dd
{
    return [[NSDate hsy_formatterWithString:DateFormater_yyyy_MM_dd] stringFromDate:self];
}

- (NSString *)hsy_stringMMdd
{
    return [[NSDate hsy_formatterWithString:DateFormater_MMdd] stringFromDate:self];
}

- (NSString *)hsy_stringMM_dd
{
    return [[NSDate hsy_formatterWithString:DateFormater_MM_dd] stringFromDate:self];
}

- (NSString *)hsy_stringHHmmss
{
    return [[NSDate hsy_formatterWithString:DateFormater_HHmmss] stringFromDate:self];
}

- (NSString *)hsy_stringHHmm
{
    return [[NSDate hsy_formatterWithString:DateFormater_HHmm] stringFromDate:self];
}

#pragma mark - To Week

+ (NSString *)hsy_dateToWeek
{
    NSDictionary *weekday = @{@(kHSYMethodsToolsKitWeekStateSunday) : kHSYMethodsToolsForSunday,
                              @(kHSYMethodsToolsKitWeekStateMonday) : kHSYMethodsToolsForMonday,
                              @(kHSYMethodsToolsKitWeekStateTuesday) : kHSYMethodsToolsForTuesday,
                              @(kHSYMethodsToolsKitWeekStateWednesday) : kHSYMethodsToolsForWednesday,
                              @(kHSYMethodsToolsKitWeekStateThursday) : kHSYMethodsToolsForThursday,
                              @(kHSYMethodsToolsKitWeekStateFriday) : kHSYMethodsToolsForFriday,
                              @(kHSYMethodsToolsKitWeekStateSaturday) : kHSYMethodsToolsForSaturday,};
    NSString *week = weekday[@(self.class.hsy_weekdayEnum)];
    return HSYLOCALIZED(week);
}

+ (kHSYMethodsToolsKitWeekState)hsy_weekdayEnum
{
    return ((kHSYMethodsToolsKitWeekState)self.class.hsy_weekday);
}

+ (NSInteger)hsy_weekday
{
    NSDateComponents *comps = [self.class hsy_weekDateComponents];
    return comps.weekday;
}

+ (NSDateComponents *)hsy_weekDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay |
                                NSCalendarUnitWeekday |
                                NSCalendarUnitHour |
                                NSCalendarUnitMinute |
                                NSCalendarUnitSecond);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:self.class.hsy_realDate];
    
    return comps;
}

#pragma mark - Equal Date

- (BOOL)hsy_isEqualDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay |
                                NSCalendarUnitWeekday |
                                NSCalendarUnitHour |
                                NSCalendarUnitMinute |
                                NSCalendarUnitSecond);
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents *comp2 = [calendar  components:unitFlags fromDate:date];
    return ([comp1 day] == [comp2 day] &&
            [comp1 month] == [comp2 month] &&
            [comp1 year] == [comp2 year] &&
            [comp1 weekday] == [comp2 weekday] &&
            [comp1 hour] == [comp2 hour] &&
            [comp1 minute] == [comp2 minute] &&
            [comp1 second] == [comp2 second]);
}

- (BOOL)hsy_isEqualDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay);
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents *comp2 = [calendar  components:unitFlags fromDate:date];
    return ([comp1 day] == [comp2 day] &&
            [comp1 month] == [comp2 month] &&
            [comp1 year] == [comp2 year]);
}

- (BOOL)hsy_isEqualMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth);
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date];
    return ([comp1 month] == [comp2 month] &&
            [comp1 year] == [comp2 year]);
}

- (BOOL)hsy_isEqualYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear);
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date];
    return ([comp1 year] == [comp2 year]);
}


@end
