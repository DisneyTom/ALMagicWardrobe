//
//  ALUtilities.h
//  RecordingDemo
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRUtilities : NSObject
+ (NSString *)minutesWithSeconds:(float)seconds;
+ (NSString *)bundlePath:(NSString *)fileName;
+ (NSString *)documentsPath:(NSString *)fileName;
+ (NSURL *)urlBundlePath:(NSString *)fileName;
+ (NSURL *)urlDocumentsPath:(NSString *)fileName;
@end
