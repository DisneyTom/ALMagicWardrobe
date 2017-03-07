//
//  ALTestComSetViewController.h
//  ALMagicWardrobe
//
//  Created by OCN on 15-4-28.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALBaseViewController.h"
typedef enum {
    ALStyle_type, //主打风格
    ALTryStyle_type, //尝试风格
    ALNonAcceptanceColor_type, //不能接受的颜色
    ALNonAcceptancePattern_type, //不能接受的图案
    ALNonAcceptanceTechnology_type //不能接受的工艺
}ALTestEnum;

typedef void (^BackBlock)(id sender);
/**
 *  修改测试通用工具类
 */
@interface ALTestComSetViewController : ALBaseViewController
@property(nonatomic) ALTestEnum theType;
@property(nonatomic,copy) BackBlock theBlock;
@end
