//
//  HSYBundleMacro.h
//  HSYMacroKit
//
//  Created by anmin on 2019/9/27.
//

#ifndef HSYBundleMacro_h
#define HSYBundleMacro_h

#define HSY_APP_BUNDLE_VERSION              [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]
#define HSY_APP_BUNDLE_NAME                 [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"]
#define HSY_APP_BUNDLE_ID                   [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"]
#define HSY_APP_BUNDLE_BUILDS               [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"]
#define HSY_APP_BUNDLE_BUILDS               [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"]
#define HSY_APP_BUNDLE_TARGET_NAME          [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"]

#endif /* HSYBundleMacro_h */
