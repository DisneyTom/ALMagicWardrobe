//
//  ALMagicWardrobeClothsModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-29.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALMagicWardrobeClothsModel : ALBaseModel
@property(nonatomic,copy) NSString *fashion_id;
@property(nonatomic,copy) NSString *fashion_type;
@property(nonatomic,copy) NSString *mwColothsId;
@property(nonatomic,copy) NSString *isabandon;
@property(nonatomic,copy) NSString *main_image;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *user_id;


/**
 *  是否是选中状态
 */
@property (nonatomic,assign) BOOL isSelected;

+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
