//
//  NSObject+Truntimetest.h
//  tour Manager
//
//  Created by anlun on 14-8-27.
//  Copyright (c) 2014年 anlun. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  此类是测试用，使用了runtime，答应对象，以便方便调试
 */
@interface NSObject (Truntimetest)
/**
 *  答应对象
 *
 *  @param obj 答应的对象
 */
-(void)printAll:(id)obj;
@end
