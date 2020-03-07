//
//  UITextField+UIKit.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import "UITextField+UIKit.h"
#import "ReactiveObjC.h"
#import "NSObject+Property.h"

static NSString *kHSYMethodsToolsRegularShouldChangeCharactersForKey      = @"HSYMethodsToolsRegularShouldChangeCharactersForKey";

@implementation UITextField (UIKit)

#pragma mark - Init

+ (instancetype)hsy_textFieldWithChanged:(void(^)(NSString *text))changedBlock
{
    UITextField *textField = [[UITextField alloc] init];
    [[textField.rac_textSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:changedBlock];
    return textField;
}

+ (instancetype)hsy_textFieldWithRegular:(NSString *)regular
{
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = textField;
    textField.hsy_regular = regular;
    return textField;
}

#pragma mark - Runtime

- (NSString *)hsy_regular
{
    return [self hsy_getPropertyForKey:kHSYMethodsToolsRegularShouldChangeCharactersForKey];
}

- (void)setHsy_regular:(NSString *)hsy_regular
{
    [self hsy_setProperty:hsy_regular
                   forKey:kHSYMethodsToolsRegularShouldChangeCharactersForKey
    objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyNonatomicCopy];
}

#pragma UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.hsy_regular.length) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.hsy_regular];
        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (![predicate evaluateWithObject:toString]) {
            return [predicate evaluateWithObject:toString];
        }
    }
    return YES;
}

#pragma mark - Will Text

+ (NSString *)hsy_shouldChangedCharcters:(UITextField *)textField inRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return result;
}

- (NSString *)hsy_shouldChangedCharcters:(NSRange)range replacementString:(NSString *)string
{
    return [UITextField hsy_shouldChangedCharcters:self inRange:range replacementString:string];
}

@end
