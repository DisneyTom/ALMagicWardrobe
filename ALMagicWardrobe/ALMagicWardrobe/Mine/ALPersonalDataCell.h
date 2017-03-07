//
//  ALPersonalDataCell.h
//  ALMagicWardrobe
//
//  Created by anLun on 15-2-13.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALPeriodicalsModel.h"
#import "OcnTableViewCell.h"

@interface ALPersonalDataCell : UITableViewCell
-(void)setLeft:(NSString *)leftStr andRight:(NSString *)rightStr;
@end


@interface MBSetingPersonSubCell : UITableViewCell

@property (nonatomic, strong) ALLabel *leftLabel;
@property (nonatomic, strong) ALLabel *rightLabel;
@property (nonatomic, strong) ALImageView *rightImage;
//@property (nonatomic, strong) UIImageView *seperateImg;
-(void)setLeft:(NSString *)leftStr andRight:(NSString *)rightStr;

@end


@interface MBCollectionShopCell : OcnTableViewCell

@property (nonatomic, strong) ALLabel *leftLabel;
@property (nonatomic, strong) ALImageView *leftImageView;
-(void)setModel:(ALPeriodicalsModel *)theModel;
@end