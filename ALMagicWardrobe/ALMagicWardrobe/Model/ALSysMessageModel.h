//
//  ALSysMessageModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-28.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALSysMessageModel : ALBaseModel
@property(nonatomic,copy) NSString *sysMessageId;
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *message;
@property(nonatomic,copy) NSString *opentype;
@property(nonatomic,copy) NSString *createdate;
+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
