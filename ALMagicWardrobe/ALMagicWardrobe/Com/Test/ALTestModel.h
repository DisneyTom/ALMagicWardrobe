//
//  ALTestModel.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseModel.h"

@interface ALTestModel : ALBaseModel
@property(nonatomic,copy) NSString *userId; // Y                      用户id
@property(nonatomic,copy) NSString *height; // Y                     身高
@property(nonatomic,copy) NSString *weight; // Y                    体重
@property(nonatomic,copy) NSString *bar_size; // Y                   下胸围
@property(nonatomic,copy) NSString *brassiere; // Y                  罩杯
@property(nonatomic,copy) NSString *yaobu; // Y                 腰部特征
@property(nonatomic,copy) NSString *tunbu; // Y                臀部特征
@property(nonatomic,copy) NSString *jianbu; // Y               肩部特征
@property(nonatomic,copy) NSString *neck; // Y              颈部特征
@property(nonatomic,copy) NSString *buttocks; // Y             上臂特征
@property(nonatomic,copy) NSString *shank; // Y            小腿特征
@property(nonatomic,copy) NSString *thigh; // Y           大腿特征
@property(nonatomic,copy) NSString *size; // Y          常规尺码
@property(nonatomic,copy) NSString *habitus; // Y         体型
@property(nonatomic,copy) NSString *bust; // N         胸围
@property(nonatomic,copy) NSString *waistline; // N        腰围
@property(nonatomic,copy) NSString *hipline; // N       臀围
@property(nonatomic,copy) NSString *shoulder; // Y      肩宽
@property(nonatomic,copy) NSString *age_group; // Y      年龄段
@property(nonatomic,copy) NSString *occupation; //      职业
@property(nonatomic,copy) NSString *style; //      风格
@property(nonatomic,copy) NSString *wish_style; //     期望风格
@property(nonatomic,copy) NSString *avoid_colour; //     避免颜色
@property(nonatomic,copy) NSString *avoid_pic; //    避免图案
@property(nonatomic,copy) NSString *avoid_tec; //   避免工艺
@property(nonatomic,copy) NSString *birthday; //  生日
@property(nonatomic,copy) NSString *status; //  状态
@property(nonatomic,copy) NSString *wish; // 心愿
@end
