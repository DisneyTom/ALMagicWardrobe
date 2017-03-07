//
//  ALMagicShowModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-8.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALMagicShowModel : ALBaseModel
@property(nonatomic,copy) NSString *contents;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *expressId;
@property(nonatomic,copy) NSString *magicShowId;
@property(nonatomic,copy) NSString *imageurls;
@property(nonatomic,copy) NSString *magicId;
@property(nonatomic,copy) NSString *userId;

+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
