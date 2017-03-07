//
//  MGUI_SquareTableViewCell.h
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/7.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGData_KeyFashions.H"
typedef void (^SquareBolock)(NSInteger index);
@interface MGUI_SquareTableViewCell : UITableViewCell
@property(nonatomic,copy) SquareBolock theBlock;
-(void)setModel:(MGData_KeyFashions *)theModel;
@end
