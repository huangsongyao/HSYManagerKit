#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSArray+Finder.h"
#import "NSArray+GridsAlgorithm.h"
#import "NSBundle+CFBundle.h"
#import "NSBundle+PrivateFileResource.h"
#import "NSData+Encrypt.h"
#import "NSDate+Timestamp.h"
#import "NSDictionary+JSON.h"
#import "NSError+Message.h"
#import "NSFileManager+Finder.h"
#import "NSMutableArray+BasicAlgorithm.h"
#import "NSMutableArray+Operations.h"
#import "NSObject+JSONModel.h"
#import "NSObject+JSONModelForRuntime.h"
#import "NSObject+Property.h"
#import "NSObject+Runtime.h"
#import "NSString+Regular.h"
#import "NSString+Replace.h"
#import "NSString+StringSize.h"
#import "RACSignal+Combined.h"
#import "RACSignal+Convenients.h"
#import "RACSignal+Timer.h"
#import "CIDetector+QRImage.h"
#import "UIAlertController+RACSignal.h"
#import "UIApplication+AppDelegates.h"
#import "UIApplication+OpenURL.h"
#import "UIBezierPath+Shape.h"
#import "UIButton+Loading.h"
#import "UIButton+UIKit.h"
#import "UIColor+Hex.h"
#import "UIImage+Canvas.h"
#import "UIImage+Compression.h"
#import "UIImage+Formatter.h"
#import "UIImageView+UrlString.h"
#import "UIImageView+ZoomScale.h"
#import "UILabel+AttributedString.h"
#import "UILabel+SuggestSize.h"
#import "UINavigationBar+Background.h"
#import "UINavigationBar+NavigationItem.h"
#import "UINavigationController+Finder.h"
#import "UIResponder+Orientation.h"
#import "UIScrollView+Pages.h"
#import "UITableView+Operations.h"
#import "UITextField+UIKit.h"
#import "UITextView+UIKit.h"
#import "UIView+Frame.h"
#import "UIView+Layer.h"
#import "UIView+Rotated.h"
#import "UIView+Snaps.h"
#import "UIViewController+Controller.h"
#import "UIViewController+Load.h"
#import "UIViewController+SystemShared.h"

FOUNDATION_EXPORT double HSYMethodsToolsKitVersionNumber;
FOUNDATION_EXPORT const unsigned char HSYMethodsToolsKitVersionString[];

