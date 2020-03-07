//
//  NSData+Encrypt.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSData+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#import "HSYToolsMacro.h"

@implementation NSData (Encrypt)

#pragma mark - Base64

+ (NSString *)hsy_base64EncodedString:(NSString *)string
{
    NSData *base64Data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [base64Data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return base64String;
}

+ (NSString *)hsy_base64DecodeData:(NSString *)string
{
    NSData *decode64Data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decode64String = [[NSString alloc] initWithData:decode64Data encoding:NSUTF8StringEncoding];
    return decode64String;
}

#pragma mark - MD5

+ (NSString *)hsy_md5:(NSString *)string
{
    const char *str = [string UTF8String];
    unsigned char hash[16];
    CC_MD5(str, (CC_LONG)strlen(str), hash);
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i = 0; i < 16; ++i) {
        [result appendFormat:@"%02X", hash[i]];
    }
    return result;
}

#pragma mark - AES-128-CBC

- (NSData *)hsy_AES128operation:(CCOperation)operation offsetIv:(NSString *)iv forKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = self.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          self.bytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)hsy_AES128EncryptWithKey:(NSString *)key offsetIv:(NSString *)iv
{
    return [self hsy_AES128operation:kCCEncrypt offsetIv:iv forKey:key];
}

- (NSData *)hsy_AES128DecryptWithKey:(NSString *)key offsetIv:(NSString *)iv
{
    return [self hsy_AES128operation:kCCDecrypt offsetIv:iv forKey:key];
}

+ (NSString *)hsy_AES128EncryptString:(NSString *)string forKey:(NSString *)key offsetIv:(NSString *)iv
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aes128EncyptData = [data hsy_AES128EncryptWithKey:key offsetIv:iv];
    NSString *aes128EncyptString = [aes128EncyptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"\n AES-128-CBC Encrypt : %@ \n", aes128EncyptString);
    return aes128EncyptString;
}

+ (NSString *)hsy_AES128DecryptString:(NSString *)string forKey:(NSString *)key offsetIv:(NSString *)iv
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *aes128DecryptData = [data hsy_AES128DecryptWithKey:key offsetIv:iv];
    NSString *aes128DecryptString = [[NSString alloc] initWithData:aes128DecryptData encoding:NSUTF8StringEncoding];
    NSLog(@"\n AES-128-CBC Decrypt : %@ \n", aes128DecryptString);
    return aes128DecryptString;
}

#pragma mark - HMAC-SHA1

+ (NSString *)hsy_HMACSHA1Base64EncryptString:(NSString *)string forKey:(NSString *)key
{
    const char *cString = [string cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cString, strlen(cString), cHMAC);
    NSData *SHA1EncryptData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *SHA1EncryptString = [SHA1EncryptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"\n SHA1EncryptString is %@ \n", SHA1EncryptString);
    return SHA1EncryptString;
}

+ (NSString *)hsy_HMACSHA1EncryptString:(NSString *)string forKey:(NSString *)key
{
    const char *cString = [string cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cString, strlen(cString), cHMAC);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x", cHMAC[i]];
    }
    NSString *SHA1EncryptString = output;
    NSLog(@"\n SHA1EncryptString is %@ \n", SHA1EncryptString);
    return SHA1EncryptString;
}

#pragma mark - URLEncoded && URLDecoded

+ (NSString *)hsy_URLEncoded:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR("!*'();:@&=+$,/?%#[] "), kCFStringEncodingUTF8));
    return result;
}

+ (NSString *)hsy_URLDecodedString:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)string, CFSTR(""), kCFStringEncodingUTF8));
    return result;
}


@end
