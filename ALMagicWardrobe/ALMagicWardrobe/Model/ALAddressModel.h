//
//  ALAddressModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-28.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALAddressModel : ALBaseModel
@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *addresstitle;
@property(nonatomic,copy) NSString *area;
@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *addressId;
@property(nonatomic,copy) NSString *isdefault;
@property(nonatomic,copy) NSString *linkman;
@property(nonatomic,copy) NSString *postcode;
@property(nonatomic,copy) NSString *province;
@property(nonatomic,copy) NSString *tel;
@property(nonatomic,copy) NSString *usreId;
+(instancetype)questionWithDict:(NSDictionary *)comeDic;
@end
