//
//  NSObject+JSONModel.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import "NSObject+JSONModel.h"
#import "JSONModel.h"
#import "NSObject+JSONModelForRuntime.h"
#import "NSObject+Runtime.h"
#import "HSYToolsMacro.h"
#import "NSError+Message.h"
#import "NSArray+Finder.h"

@implementation NSObject (JSONModel)

+ (id)hsy_toJSONModel:(NSObject *)json forModelClasses:(Class)classes
{
    BOOL isNSArrayClasses = [json isKindOfClass:[NSArray class]];
    if ([json isKindOfClass:[NSDictionary class]] || isNSArrayClasses) {
        id object = (isNSArrayClasses ? classes : [classes alloc]);
        NSString *methodString = (isNSArrayClasses ? NSStringFromSelector(@selector(arrayOfModelsFromDictionaries:error:)) :   NSStringFromSelector(@selector(initWithDictionary:error:)));
        id result = nil;
        NSError *error = nil;
        HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(result = [object performSelector:NSSelectorFromString(methodString) withObject:json withObject:error]);
        if (error) {
            return error;
        }
        return result;
    }
    
    return NSError.hsy_defaultJSONModelErrorMessage;
}

@end
