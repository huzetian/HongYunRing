//
//  NSString+Encrypto.m
//  TCPCommunication
//
//  Created by imac on 15/11/4.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "NSString+Encrypto.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Encrypto)

- (NSString*) sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
