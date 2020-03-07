//
//  UITextView+UIKit.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import "UITextView+UIKit.h"
#import "ReactiveObjC.h"
#import "NSObject+Property.h"

static NSString *kHSYMethodsToolsRegularCharactersForKey      = @"HSYMethodsToolsRegularCharactersForKey";

@implementation UITextView (UIKit) 

#pragma mark - Init

+ (instancetype)hsy_textViewWithChanged:(void(^)(NSString *text))changedBlock
{
    UITextView *textView = [[UITextView alloc] init];
    [[textView.rac_textSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:changedBlock];
    return textView;
}

+ (instancetype)hsy_textViewWithRegular:(NSString *)regular
{
    UITextView *textView = [[UITextView alloc] init];
    textView.delegate = textView;
    textView.hsy_regular = regular;
    return textView;
}

#pragma mark - Runtime

- (NSString *)hsy_regular
{
    return [self hsy_getPropertyForKey:kHSYMethodsToolsRegularCharactersForKey];
}

- (void)setHsy_regular:(NSString *)hsy_regular
{
    [self hsy_setProperty:hsy_regular
                   forKey:kHSYMethodsToolsRegularCharactersForKey
    objcAssociationPolicy:kHSYMethodsToolsKitObjcAssociationPolicyNonatomicCopy];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.hsy_regular.length) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.hsy_regular];
        NSString *toString = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if (![predicate evaluateWithObject:toString]) {
            return [predicate evaluateWithObject:toString];
        }
    }
    return YES;
}

#pragma mark - Will Text

+ (NSString *)hsy_shouldChangedCharcters:(UITextView *)textView inRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *result = [textView.text stringByReplacingCharactersInRange:range withString:string];
    return result;
}

- (NSString *)hsy_shouldChangedCharcters:(NSRange)range replacementString:(NSString *)string
{
    return [UITextView hsy_shouldChangedCharcters:self inRange:range replacementString:string];
}


@end
