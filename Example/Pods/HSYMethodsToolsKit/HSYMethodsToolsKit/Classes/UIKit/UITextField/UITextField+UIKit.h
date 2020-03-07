//
//  UITextField+UIKit.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (UIKit) <UITextFieldDelegate> 

//记录正则
@property (nonatomic, copy) NSString *hsy_regular;

/**
 快速创建，返回一个did changed text的block事件

 @param changedBlock did changed text的block事件
 @return UITextField
 */
+ (instancetype)hsy_textFieldWithChanged:(void(^)(NSString *text))changedBlock;

/**
 快速创建，对UITextField对象本身添加UITextFieldDelegate协议，并监听- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string委托，由self.hsy_regular来决定是否需要使用正则表达式来控制输入长度

 @param regular 正则表达式
 @return UITextField
 */
+ (instancetype)hsy_textFieldWithRegular:(NSString *)regular;

/**
 在"- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string"方法中根据获取到的old-text和当前输入的range以及输入的内容string，拼接成下一步的text内容
 
 @param textField UITextField
 @param range range
 @param string string
 @return self.text的内容
 */
+ (NSString *)hsy_shouldChangedCharcters:(UITextField *)textField inRange:(NSRange)range replacementString:(NSString *)string;

/**
 在"- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string"方法中根据获取到的old-text和当前输入的range以及输入的内容string，拼接成下一步的text内容

 @param range range
 @param string string
 @return self.text的内容
 */
- (NSString *)hsy_shouldChangedCharcters:(NSRange)range replacementString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
