//
//  ALMineAddressCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-4-15.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "OcnTableViewCell.h"
#import "ALAddressModel.h"
typedef void (^AddressBackBlock)(BOOL sel);
@interface ALMineAddressCell : OcnTableViewCell
-(void)setModel:(ALAddressModel *)theModel;
-(void)setSel:(BOOL)sel;
@property(nonatomic,copy) AddressBackBlock theBlock;
@end
