//
//  GRLogs.h
//  GameRec
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#undef	NSLog
#define NSLog GRLog

void GRLog(NSObject *format, ...);
