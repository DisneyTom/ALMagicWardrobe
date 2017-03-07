//
//  ALMagicShowCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALMagicShowModel.h"
typedef enum {
    MSTapClick_type, //点击
    MSLongTapClick_type  //长按
}MagicShowEnum;
static float leftWidth=60;
typedef void (^MagicShowCellBlock)(MagicShowEnum theType,NSInteger index);
@interface ALMagicShowCell : UITableViewCell
-(void)setModel:(ALMagicShowModel *)theModel;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic,strong) MagicShowCellBlock theBlock;
@end
