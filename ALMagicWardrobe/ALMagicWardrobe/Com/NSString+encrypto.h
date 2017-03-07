//
//  NSString+encrypto.h
//  OcnLife
//
//  Created by chen zhuolin on 13-10-22.
//  Copyright (c) 2013年 chen zhuolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encrypto)

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha1_base64;
- (NSString *)md5_base64;
- (NSString *)base64;
- (NSString *)encodeUrlStr:(NSString *)sourceString;

@end
