//
//  ALUserModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-27.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"
@interface ALUserModel : ALBaseModel
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *userpic;
@property(nonatomic,copy) NSString *usertel;
+(instancetype)questionWithDict:(NSDictionary *)comeDic;

@end
