//
//  ALUtilities.m
//  RecordingDemo
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#import "ALUtilities.h"

@implementation ALUtilities
+ (NSString *)minutesWithSeconds:(float)seconds {
	if (seconds < 10.0f) {
        if ([[NSString stringWithFormat:@"%.0f", seconds] length] > 1) {
            return [NSString stringWithFormat:@"00:%.0f", seconds];
        }
        
		return [NSString stringWithFormat:@"00:0%.0f", seconds];
	}
	else if (seconds < 60.0f) {
		return [NSString stringWithFormat:@"00:%.0f", seconds];
	}
    
	else {
		int minutes = (int)(seconds / 60.0f);
		float second = seconds - (minutes * 60.0f);
		
		NSString *minutes_string = [NSString stringWithFormat:@"%d", minutes];
		NSString *second_string = [NSString stringWithFormat:@"%.0f", second];
		if (minutes < 10.0f) {
			minutes_string = [NSString stringWithFormat:@"0%@", minutes_string];
		}
		if (second < 10.0f) {
			second_string = [NSString stringWithFormat:@"0%@", second_string];
		}
		
		return [NSString stringWithFormat:@"%@:%@", minutes_string, second_string];
	}
}

+ (NSString *)bundlePath:(NSString *)fileName {
	return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentsPath:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (NSURL *)urlBundlePath:(NSString *)fileName {
	return [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", [ALUtilities bundlePath:fileName]]];
}

+ (NSURL *)urlDocumentsPath:(NSString *)fileName {
    return [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", [ALUtilities documentsPath:fileName]]];
}

@end
