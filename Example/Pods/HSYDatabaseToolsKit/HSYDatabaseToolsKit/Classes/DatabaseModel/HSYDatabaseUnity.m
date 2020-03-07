//
//  HSYDatabaseUnity.m
//  HSYDatabaseToolsKit
//
//  Created by anmin on 2019/10/16.
//

#import "HSYDatabaseUnity.h"

NSString *const kHSYDatabaseUnityTypeForText        = @"TEXT";

@implementation HSYDatabaseUnity

- (instancetype)initWithName:(NSString *)name andStateType:(nullable NSString *)typeString unityValue:(nullable NSString *)value
{
    if (self = [super init]) {
        _unityName = name;
        _unityState = typeString;
        _unityValue = value;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name andStateType:(NSString *)typeString
{
    return [self initWithName:name andStateType:typeString unityValue:nil];
}

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name andStateType:nil unityValue:nil];
}

#pragma mark - Column & Type

- (NSString *)hsy_unityFieldString
{
    return [NSString stringWithFormat:@"%@ %@", self.unityName, self.unityState];
} 

#pragma mark - To TEXT Formatter Value

- (NSString *)hsy_unityValueByText
{
    if ([self.unityState isEqualToString:kHSYDatabaseUnityTypeForText]) {
        return [NSString stringWithFormat:@"'%@'", self.unityValue];
    }
    return self.unityValue;
}

@end
