//
//  MGUI_TypeViewCell.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/16.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGData_Type.h"
typedef void (^ClothsCellBackBlock)(NSInteger index);

@interface MGUI_TypeViewCell : UITableViewCell
-(void)setLeftModel:(MGData_Type *)theModel;
-(void)setRightModel:(MGData_Type *)theModel;

@property(nonatomic,copy) ClothsCellBackBlock theBlock;
@end
