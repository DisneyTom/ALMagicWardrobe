//
//  ALPeriodicalsModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALPeriodicalsModel : ALBaseModel
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createDate;
@property(nonatomic,copy) NSString *createUser;
@property(nonatomic,copy) NSString *periodicalsId;
@property(nonatomic,copy) NSString *isshow;
@property(nonatomic,copy) NSString *lead;
@property(nonatomic,copy) NSString *mainImage;
@property(nonatomic,copy) NSString *title;

+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
