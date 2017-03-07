//
//  MGUI_MainCell.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/17.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGData_KeyFashions.h"
@interface MGUI_MainCell : UITableViewCell
typedef void (^SquareBolock)(NSInteger index);
@property(nonatomic,copy) SquareBolock theBlock;

-(void)setModel:(MGData_KeyFashions *)theModel;
-(void)setTime;
@end
