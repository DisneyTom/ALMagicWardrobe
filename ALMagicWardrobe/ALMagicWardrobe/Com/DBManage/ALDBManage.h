//
//  ALDBManage.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-1.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

/**
 *  数据库管理
 */
@interface ALDBManage : FMDatabaseQueue
+(ALDBManage *)sharedInstance;
@end
