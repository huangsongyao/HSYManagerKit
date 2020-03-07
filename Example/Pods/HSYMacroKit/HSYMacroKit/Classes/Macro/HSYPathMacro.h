//
//  HSYPathMacro.h
//  HSYMacroKit
//
//  Created by anmin on 2019/9/27.
//

#ifndef HSYPathMacro_h
#define HSYPathMacro_h

#define HSY_PATH_DOCUMENT               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define HSY_PATH_LIBRARY                [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]
#define HSY_PATH_CACHE                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#endif /* HSYPathMacro_h */
