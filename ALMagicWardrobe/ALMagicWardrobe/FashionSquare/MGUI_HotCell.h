//
//  MGUI_HotCell.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/6/23.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGData_KeyFashions.H"
typedef void (^HotCellBolock)(NSInteger index);
@interface MGUI_HotCell : UITableViewCell
@property(nonatomic,copy) HotCellBolock theBlock;
-(void)setModel:(MGData_KeyFashions *)theModel;
@end
